//
//  MoviesListViewModelTests.swift
//  MoviesTests
//
//  Created by Piotr Adamczak on 18/02/2021.
//

@testable import Movies
import XCTest

class MovieDetailViewModelTests: XCTestCase {
    var apiServiceMock = ApiServiceMock()
    var viewModel = DefaultMovieDetailsViewModel()

    override func setUpWithError() throws {
        try super.setUpWithError()
        apiServiceMock.mockedError = nil
        apiServiceMock.mockedResponse = nil
        apiServiceMock.pagination = nil
        viewModel.apiService = apiServiceMock
    }

    func testFetchMovies_forCorrectData() {
        let fakeMovieDetail = Movie(title: "title", year: "year", rated: "10", released: "released", runtime: "runtime", genre: "genre", director: "director", writer: "writer", actors: "actors", plot: "plot", language: "language", country: "country", awards: "awards", poster: "https://digitalindiana.pl", ratings: [], metascore: "10", imdbRating: "10", imdbVotes: "100", imdbID: "", type: "movie", dvd: "dvd", boxOffice: "123", production: "production", website: "website", response: "True")
        apiServiceMock.mockedResponse = fakeMovieDetail

        let movieDetailLoadedExpecation = expectation(description: "Movie details loaded")
        viewModel.movieLoaded = { movieViewData in
            movieDetailLoadedExpecation.fulfill()

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

        let movieMetadata = MovieMetadata(imdbID: "test")
        viewModel.fetchMovie(movieMetadata: movieMetadata)

        waitForExpectations(timeout: 2)
    }

    func testFetchMovies_forNoInternetError() {
        apiServiceMock.mockedError = .noInternet

        let errorReturnedExpecation = expectation(description: "Error called")
        viewModel.errorHandler = { error in
            errorReturnedExpecation.fulfill()
            XCTAssertEqual(error.errorDescription, NSLocalizedString("Check Internet connection and try again", comment: "No Internet Connection"))
        }

        let movieMetadata = MovieMetadata(imdbID: "test")
        viewModel.fetchMovie(movieMetadata: movieMetadata)

        waitForExpectations(timeout: 2)
    }

    func testFetchMovies_forAPIError() {
        apiServiceMock.mockedError = .response(errorFromApi: "API_ERROR")
        let errorReturnedExpecation = expectation(description: "Error called")
        viewModel.errorHandler = { error in
            errorReturnedExpecation.fulfill()
            XCTAssertEqual(error.errorDescription, "API_ERROR")
        }

        let movieMetadata = MovieMetadata(imdbID: "test")
        viewModel.fetchMovie(movieMetadata: movieMetadata)

        waitForExpectations(timeout: 2)
    }

    func testFetchMovies_forGeneralError() {
        apiServiceMock.mockedError = .generalError(error: TestError.testError)

        let errorReturnedExpecation = expectation(description: "Error called")

        viewModel.errorHandler = { error in
            errorReturnedExpecation.fulfill()
            XCTAssertEqual(error.errorDescription, "TEST_ERROR")
        }

        let movieMetadata = MovieMetadata(imdbID: "test")
        viewModel.fetchMovie(movieMetadata: movieMetadata)

        waitForExpectations(timeout: 2)
    }
}
