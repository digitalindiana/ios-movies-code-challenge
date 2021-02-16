//
//  MoviesListViewModelTests.swift
//  MoviesTests
//
//  Created by Piotr Adamczak on 16/01/2021.
//

@testable import Movies
import Combine
import SwiftyMocky
import XCTest

class MovieDetailViewModelTests: XCTestCase {
    var apiServiceMock = APIServiceProtocolMock()
    let apiResponseSubject = PassthroughSubject<Movie, ApiError>()
    var viewModel = DefaultMovieDetailsViewModel()

    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel.apiService = apiServiceMock

        Matcher.default.register(OMDBApiResponseError.Type.self) { (lhs, rhs) -> Bool in
            return lhs == rhs
        }

        let mockedPublisher: AnyPublisher<Movie, ApiError>? = apiResponseSubject.eraseToAnyPublisher()
        Given(apiServiceMock, .performRequest(to: .any, responseErrorType: .value(OMDBApiResponseError.self), willReturn: mockedPublisher))
    }

    func testFetchMovies_forCorrectData() {
        let movieDetailLoadedExpecation = expectation(description: "Movie details loaded")
        let fakeMovieDetail = Movie(title: "title", year: "year", rated: "10", released: "released", runtime: "runtime", genre: "genre", director: "director", writer: "writer", actors: "actors", plot: "plot", language: "language", country: "country", awards: "awards", poster: "https://digitalindiana.pl", ratings: [], metascore: "10", imdbRating: "10", imdbVotes: "100", imdbID: "", type: "movie", dvd: "dvd", boxOffice: "123", production: "production", website: "website", response: "True")

        viewModel.movieLoaded = { movieViewData in
            movieDetailLoadedExpecation.fulfill()

            XCTAssertEqual(movieViewData.header.posterImageUrl, URL(string: "https://digitalindiana.pl"))
            XCTAssertEqual(movieViewData.header.title, "title")
            XCTAssertEqual(movieViewData.header.year, "year")
            XCTAssertEqual(movieViewData.general.categories, "genre")
            XCTAssertEqual(movieViewData.general.duration, "runtime")
            XCTAssertEqual(movieViewData.general.popularity, "10")
            XCTAssertEqual(movieViewData.general.rating, "⭐ 10")
            XCTAssertEqual(movieViewData.general.reviews, "100")
            XCTAssertEqual(movieViewData.general.score, "10")
            XCTAssertEqual(movieViewData.general.synopsis, "plot")
            XCTAssertEqual(movieViewData.cast.actors, "actors")
            XCTAssertEqual(movieViewData.cast.director, "director")
            XCTAssertEqual(movieViewData.cast.writer, "writer")
        }

        viewModel.fetchMovie(imdbID: "id")
        apiResponseSubject.send(fakeMovieDetail)
        waitForExpectations(timeout: 2)
    }

    func testFetchMovies_forNoInternetError() {
        let errorReturnedExpecation = expectation(description: "Error called")

        viewModel.errorHandler = { error in
            errorReturnedExpecation.fulfill()
            XCTAssertEqual(error.errorDescription, NSLocalizedString("Check Internet connection and try again", comment: "No Internet Connection"))
        }

        viewModel.fetchMovie(imdbID: "1")
        apiResponseSubject.send(completion: Subscribers.Completion<ApiError>.failure(.noInternet))
        waitForExpectations(timeout: 2)
    }

    func testFetchMovies_forAPIError() {
        let errorReturnedExpecation = expectation(description: "Error called")

        viewModel.errorHandler = { error in
            errorReturnedExpecation.fulfill()
            XCTAssertEqual(error.errorDescription, "API_ERROR")
        }

        viewModel.fetchMovie(imdbID: "1")
        apiResponseSubject.send(completion: Subscribers.Completion<ApiError>.failure(.response(errorFromApi: "API_ERROR")))
        waitForExpectations(timeout: 2)
    }

    func testFetchMovies_forGeneralError() {
        let errorReturnedExpecation = expectation(description: "Error called")

        viewModel.errorHandler = { error in
            errorReturnedExpecation.fulfill()
            XCTAssertEqual(error.errorDescription, "TEST_ERROR")
        }

        viewModel.fetchMovie(imdbID: "1")
        apiResponseSubject.send(completion: Subscribers.Completion<ApiError>.failure(.generalError(error: TestError.testError)))
        waitForExpectations(timeout: 2)
    }

}
