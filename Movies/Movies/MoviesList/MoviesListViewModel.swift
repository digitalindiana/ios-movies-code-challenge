//
//  MoviesListViewModel.swift
//  Movies
//
//  Created by Piotr Adamczak on 13/01/2021.
//

import Combine
import Foundation
import Logging
import SDWebImage
import UIKit

enum MoviesListSection {
    case movies
}

typealias MoviesDataSource = UICollectionViewDiffableDataSource<MoviesListSection, MovieMetadata>
typealias MoviesDataSnapshot = NSDiffableDataSourceSnapshot<MoviesListSection, MovieMetadata>

// sourcery: AutoMockable
protocol MoviesListViewModelProtocol {
    // DataSource for collection view diffable data source
    var dataSource: MoviesDataSource? { get }

    // API Service
    var apiService: APIServiceProtocol? { get }

    // Handlers
    var moviesLoaded: (([MovieMetadata]) -> Void)? { get set }
    var errorHandler: ((ErrorData) -> Void)? { get set }

    // Setting up the data source for collection view
    func setupDataSource(for collectionView: UICollectionView)
    func clearData(generateError: Bool)

    // Getting the actual data
    var currentMovies: [MovieMetadata] { get }
    func fetchMovies(searchedTitle: String, forced: Bool)
    func fetchMoreMovies()
}

class DefaultMoviesListViewModel: NSObject, MoviesListViewModelProtocol {
    var apiService: APIServiceProtocol? = OMDBApiService()
    var dataSource: MoviesDataSource?

    var moviesLoaded: (([MovieMetadata]) -> Void)?
    var errorHandler: ((ErrorData) -> Void)?

    var currentMovies: [MovieMetadata] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.updateListWith(self.currentMovies)
            }
        }
    }

    // Flag used for loading one request at time if needed
    var isLoadingData = false

    // Save the publishers references to remove them from memory
    var subscriptions: Set<AnyCancellable> = Set()

    /// Setup of UICollectionViewDiffableDataSource
    /// - Parameter collectionView: UICollectionView
    func setupDataSource(for collectionView: UICollectionView) {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView,
                                                        cellProvider: { (collectionView, indexPath, movie) -> UICollectionViewCell? in

                                                            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCell.reuseIdentifier,
                                                                                                             for: indexPath) as? MovieListCell {
                                                                cell.movieTitleLabel?.text = movie.title
                                                                cell.posterImageView?.sd_setImage(with: URL(string: movie.poster))
                                                                return cell
                                                            }
                                                            return UICollectionViewCell()
                                                        })
    }

    /// Returns pagination object for given search term
    /// - Parameter searchedTitle: Movie title to search
    /// - Returns: Pagination
    func paginationForTerm(_ searchedTitle: String) -> Pagination {
        // If we are searching the same item -> increment page
        if let lastPagination = apiService?.pagination,
           lastPagination.queryItem == searchedTitle {
            return lastPagination.nextPagination()
        } else {
            // Do not inform UI - let the old data stay for a moment
            clearData(generateError: false)
            return DefaultPagination(queryItem: searchedTitle)
        }
    }

    /// Fetches movies list for given term - use force option to allow multiple data loading at one time
    /// - Parameters:
    ///   - searchedTitle: Movie title to search
    ///   - forced: Allow multiple data loading at one time
    func fetchMovies(searchedTitle: String, forced: Bool) {
        if isLoadingData && !forced {
            return
        }

        // Let's get pagination term for current title
        let pagination = paginationForTerm(searchedTitle)
        if !pagination.hasMoreData() {
            LoggerService.shared.debug("Got all data for term: \(pagination.queryItem)")
            return
        }

        LoggerService.shared.debug("Getting movies for \(searchedTitle)")
        isLoadingData = true

        // Create endpoint using given title and pagination
        let endpoint = OMDBApiEndpoint.moviesList(searchedTitle: searchedTitle, page: pagination.currentPage)
        let publisher: AnyPublisher<MoviesListResponse, ApiError>? = apiService?.performRequest(to: endpoint,
                                                                                                responseErrorType: OMDBApiResponseError.self)
        publisher?.receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }

                // Receives the error from API Response or network error
                if case let .failure(apiError) = completion {
                    LoggerService.shared.error("Got error while on receving movies: \(apiError)")

                    // Inform about error
                    self.errorHandler?(OMDBErrorData(apiError: apiError))
                }

                self.isLoadingData = false

            }, receiveValue: { [weak self] moviesListResponse in
                guard let self = self else { return }

                if let totalResults = Int(moviesListResponse.totalResults) {
                    let movies = moviesListResponse.movies
                    LoggerService.shared.debug("Got response with \(movies.count) movies, total:\(totalResults)")

                    self.currentMovies.append(contentsOf: movies)
                    self.apiService?.pagination = pagination.update(savedItems: self.currentMovies.count,
                                                                    totalItems: totalResults)
                    // Inform about success load
                    self.moviesLoaded?(self.currentMovies)
                }

            }).store(in: &subscriptions)
    }

    /// Helper method for loading more data
    func fetchMoreMovies() {
        if let lastPagination = apiService?.pagination {
            fetchMovies(searchedTitle: lastPagination.queryItem, forced: false)
        }
    }

    /// Clear displayed data
    /// - Parameter generateError: Generates empty query error to adjust UI
    func clearData(generateError: Bool) {
        currentMovies.removeAll()
        apiService?.pagination = nil

        if generateError {
            errorHandler?(OMDBErrorData.emptyQuery)
        }
    }

    /// Updates the list with given movies list
    /// - Parameter movies: [MovieMetadata]
    func updateListWith(_ movies: [MovieMetadata]) {
        var snapshot = MoviesDataSnapshot()
        if movies.count == 0 {
            snapshot.deleteAllItems()
        } else {
            snapshot.appendSections([.movies])
            snapshot.appendItems(movies)
        }
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}
