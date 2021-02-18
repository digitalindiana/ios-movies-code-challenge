//
//  MoviesListViewModel.swift
//  Movies
//
//  Created by Piotr Adamczak on 16/02/2021.
//

import Foundation
import UIKit

typealias MovieDetailsViewModelDataTuple = (header: MovieDetailsHeaderModel,
                                            general: MovieDetailsGeneralInfoModel,
                                            cast: MovieDetailsCastInfoModel)

protocol MovieDetailViewModelProtocol {
    // API Service
    var apiService: APIServiceProtocol? { get }
    var additionalApiService: APIServiceProtocol? { get }

    // Handlers
    var movieLoaded: ((MovieDetailsViewModelDataTuple) -> Void)? { get set }
    var errorHandler: ((ErrorData) -> Void)? { get set }

    var reviewsLoaded: (([MovieReview]) -> Void)? { get set }
    var reviewsErrorHandler: ((ErrorData) -> Void)? { get set }

    // Data related
    var movieData: MovieDetailsViewModelDataTuple? { get set }
    var reviews: [MovieReview]? { get set }
    func fetchMovie(movieMetadata: MovieMetadata)
    func fetchReviews(movieMetadata: MovieMetadata)
}

class DefaultMovieDetailsViewModel: NSObject, MovieDetailViewModelProtocol {
    var apiService: APIServiceProtocol? = OMDBApiService()
    var additionalApiService: APIServiceProtocol? = NYTimesApiService()

    var movieLoaded: ((MovieDetailsViewModelDataTuple) -> Void)?
    var reviewsLoaded: (([MovieReview]) -> Void)?
    var errorHandler: ((ErrorData) -> Void)?
    var reviewsErrorHandler: ((ErrorData) -> Void)?

    var movieData: MovieDetailsViewModelDataTuple?
    var reviews: [MovieReview]? = []

    /// Fetches the details for given movie ID
    /// - Parameter imdbID: String
    func fetchMovie(movieMetadata: MovieMetadata) {
        LoggerService.shared.debug("Getting movie \(movieMetadata.imdbID)")

        let endpoint = OMDBApiEndpoint.movieDetail(imdbID: movieMetadata.imdbID)

        apiService?.performRequest(to: endpoint, responseType: Movie.self, responseErrorType: OMDBApiResponseError.self) { result in

            switch result {
            case .failure(let apiError):
                LoggerService.shared.error("Got error while on receving movie: \(apiError)")
                self.errorHandler?(OMDBErrorData(apiError: apiError))

            case .success(let movie):
                LoggerService.shared.debug("Got response with \(movie) movie")
                self.movieData = self.viewData(for: movie, poster: movieMetadata.cachedPoster)
                
                if let movieData = self.movieData {
                    self.movieLoaded?(movieData)
                }
            }
        }
    }

    /// Fetches the details for given movie ID
    /// - Parameter imdbID: String
    func fetchReviews(movieMetadata: MovieMetadata) {
        LoggerService.shared.debug("Getting movie \(movieMetadata.imdbID)")

        let endpoint = NYTApiEndpoint.movieReviews(searchedTitle: movieMetadata.title)

        additionalApiService?.performRequest(to: endpoint, responseType: MovieReviewsResponse.self) { result in
    
            switch result {
            case .failure(let apiError):
                LoggerService.shared.error("Got error while on receving reviews: \(apiError)")
                self.reviewsErrorHandler?(NYTimesErrorData(apiError: .response(errorFromApi: "Cannot find reviews")))

            case .success(let movieReviewResponse):
                LoggerService.shared.debug("Got response with \(movieReviewResponse.results.count) reviews")
                self.reviews = movieReviewResponse.results
                self.reviewsLoaded?(movieReviewResponse.results)
            }
        }
    }

    /// Converts model into the data created for view
    /// - Parameter movie: Movie
    /// - Returns: Tuple with header, general and cast informations
    func viewData(for movie: Movie, poster: UIImage?) -> MovieDetailsViewModelDataTuple {
        let header = MovieDetailsHeaderModel(cachedPoster: poster,
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
