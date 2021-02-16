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

typealias MovieDetailsViewModelDataTuple = (header: MovieDetailsHeaderModel,
                                            general: MovieDetailsGeneralInfoModel,
                                            cast: MovieDetailsCastInfoModel)
// sourcery: AutoMockable
protocol MovieDetailViewModelProtocol {
    // API Service
    var apiService: APIServiceProtocol? { get }

    // Handlers
    var movieLoaded: ((MovieDetailsViewModelDataTuple) -> Void)? { get set }
    var errorHandler: ((ErrorData) -> Void)? { get set }

    // Data related
    var currentMovie: Movie? { get set }
    func fetchMovie(imdbID: String)
}

class DefaultMovieDetailsViewModel: NSObject, MovieDetailViewModelProtocol {
    var apiService: APIServiceProtocol? = OMDBApiService()

    var movieLoaded: ((MovieDetailsViewModelDataTuple) -> Void)?
    var errorHandler: ((ErrorData) -> Void)?

    var currentMovie: Movie?

    var subscriptions: Set<AnyCancellable> = Set()

    /// Fetches the details for given movie ID
    /// - Parameter imdbID: String
    func fetchMovie(imdbID: String) {
        LoggerService.shared.debug("Getting movie \(imdbID)")

        let endpoint = OMDBApiEndpoint.movieDetail(imdbID: imdbID)
        let publisher: AnyPublisher<Movie, ApiError>? = apiService?.performRequest(to: endpoint,
                                                                                   responseErrorType: OMDBApiResponseError.self)
        publisher?.receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }

                if case let .failure(apiError) = completion {
                    LoggerService.shared.error("Got error while on receving movie: \(apiError)")
                    self.errorHandler?(OMDBErrorData(apiError: apiError))
                }

            }, receiveValue: { [weak self] movie in
                guard let self = self else { return }
                LoggerService.shared.debug("Got response with \(movie) movie")
                self.currentMovie = movie
                self.movieLoaded?(self.viewData(for: movie))

            }).store(in: &subscriptions)
    }

    /// Converts model into the data created for view
    /// - Parameter movie: Movie
    /// - Returns: Tuple with header, general and cast informations
    func viewData(for movie: Movie) -> MovieDetailsViewModelDataTuple {
        let header = MovieDetailsHeaderModel(posterImageUrl: URL(string: movie.poster),
                                             title: movie.title,
                                             year: movie.year)

        let generalInfo = MovieDetailsGeneralInfoModel(categories: movie.genre,
                                                       duration: movie.runtime,
                                                       rating: "⭐ \(movie.imdbRating)",
                                                       synopsis: movie.plot,
                                                       score: movie.imdbRating,
                                                       reviews: movie.imdbVotes,
                                                       popularity: movie.metascore)

        let castInfo = MovieDetailsCastInfoModel(director: movie.director,
                                                 writer: movie.writer,
                                                 actors: movie.actors)
        return (header, generalInfo, castInfo)
    }
}
