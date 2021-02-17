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

    // Handlers
    var movieLoaded: ((MovieDetailsViewModelDataTuple) -> Void)? { get set }
    var errorHandler: ((ErrorData) -> Void)? { get set }

    // Data related
    var currentMovie: Movie? { get set }
    func fetchMovie(movieMetadata: MovieMetadata)
}

class DefaultMovieDetailsViewModel: NSObject, MovieDetailViewModelProtocol {
    var apiService: APIServiceProtocol? = OMDBApiService()

    var movieLoaded: ((MovieDetailsViewModelDataTuple) -> Void)?
    var errorHandler: ((ErrorData) -> Void)?

    var currentMovie: Movie?

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
                self.currentMovie = movie
                self.movieLoaded?(self.viewData(for: movie, poster: movieMetadata.cachedPoster))
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
