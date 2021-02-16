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

public enum TestError: Error {
    case testError
}

extension TestError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .testError:
            return "TEST_ERROR"
        }
    }
}

class MoviesListViewModelTests: XCTestCase {
    var apiServiceMock = APIServiceProtocolMock()
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    let apiResponseSubject = PassthroughSubject<MoviesListResponse, ApiError>()
    var viewModel = DefaultMoviesListViewModel()

    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel.apiService = apiServiceMock
        collectionView.register(MovieListCell.self, forCellWithReuseIdentifier: MovieListCell.reuseIdentifier)
        viewModel.setupDataSource(for: collectionView)

        Matcher.default.register(OMDBApiResponseError.Type.self) { (lhs, rhs) -> Bool in
            return lhs == rhs
        }

        let mockedPublisher: AnyPublisher<MoviesListResponse, ApiError>? = apiResponseSubject.eraseToAnyPublisher()
        Given(apiServiceMock, .performRequest(to: .any, responseErrorType: .value(OMDBApiResponseError.self), willReturn: mockedPublisher))
    }

    func testPaginationForTerm_WithSameQuery() {
        let pagination = viewModel.paginationForTerm("marvel")
        XCTAssertNotNil(pagination)
        XCTAssertEqual(pagination.queryItem, "marvel")
        XCTAssertEqual(pagination.currentPage, 1)

        Given(apiServiceMock, .pagination(getter: .some(pagination)))

        let nextPagination = viewModel.paginationForTerm("marvel")
        XCTAssertNotNil(nextPagination)
        XCTAssertEqual(nextPagination.queryItem, "marvel")
        XCTAssertEqual(nextPagination.currentPage, 2)
    }

    func testPaginationForTerm_WithDifferentQuery() {
        let pagination = viewModel.paginationForTerm("marvel")
        XCTAssertNotNil(pagination)
        XCTAssertEqual(pagination.queryItem, "marvel")
        XCTAssertEqual(pagination.currentPage, 1)

        Given(apiServiceMock, .pagination(getter: .some(pagination)))

        let nextPagination = viewModel.paginationForTerm("matrix")
        XCTAssertNotNil(nextPagination)
        XCTAssertEqual(nextPagination.queryItem, "matrix")
        XCTAssertEqual(nextPagination.currentPage, 1)
    }

    func testFetchMovies_whenMoreDataAvailable() {
        let moviesLoadedExpecation = expectation(description: "Movies loaded")
        let fakeMovies = (1 ... 5).map { MovieMetadata(title: "title_\($0)", year: "2021", imdbID: "123", type: .movie, poster: "") }
        let movieListResponseMock = MoviesListResponse(movies: fakeMovies, totalResults: "15", response: "True")

        viewModel.moviesLoaded = { movies in
            moviesLoadedExpecation.fulfill()
            XCTAssertEqual(movies.count, 5)
            movies.forEach { XCTAssertEqual($0.year, "2021") }

            XCTAssertEqual(self.viewModel.currentMovies.count, 5)
            XCTAssertNotNil(self.apiServiceMock.pagination)
            XCTAssertEqual(self.apiServiceMock.pagination!.totalItems, 15)
            XCTAssertTrue(self.apiServiceMock.pagination!.hasMoreData())
        }

        viewModel.fetchMovies(searchedTitle: "test", forced: true)
        apiResponseSubject.send(movieListResponseMock)
        waitForExpectations(timeout: 2)
    }

    func testFetchMovies_forCorrectData() {
        let moviesLoadedExpecation = expectation(description: "Movies loaded")
        let fakeMovies = (1 ... 5).map { MovieMetadata(title: "title_\($0)", year: "2021", imdbID: "123", type: .movie, poster: "") }
        let movieListResponseMock = MoviesListResponse(movies: fakeMovies, totalResults: "5", response: "True")

        viewModel.moviesLoaded = { movies in
            moviesLoadedExpecation.fulfill()
            XCTAssertEqual(movies.count, 5)
            movies.forEach { XCTAssertEqual($0.year, "2021") }

            XCTAssertEqual(self.viewModel.currentMovies.count, 5)
            XCTAssertNotNil(self.apiServiceMock.pagination)
            XCTAssertEqual(self.apiServiceMock.pagination!.totalItems, 5)
            XCTAssertFalse(self.apiServiceMock.pagination!.hasMoreData())
        }

        viewModel.fetchMovies(searchedTitle: "test", forced: true)
        apiResponseSubject.send(movieListResponseMock)
        waitForExpectations(timeout: 2)
    }

    func testFetchMovies_forNoInternetError() {
        let errorReturnedExpecation = expectation(description: "Error called")

        viewModel.errorHandler = { error in
            errorReturnedExpecation.fulfill()
            XCTAssertEqual(error.errorDescription, NSLocalizedString("Check Internet connection and try again", comment: "No Internet Connection"))
        }

        viewModel.fetchMovies(searchedTitle: "test", forced: true)
        apiResponseSubject.send(completion: Subscribers.Completion<ApiError>.failure(.noInternet))
        waitForExpectations(timeout: 2)
    }

    func testFetchMovies_forAPIError() {
        let errorReturnedExpecation = expectation(description: "Error called")

        viewModel.errorHandler = { error in
            errorReturnedExpecation.fulfill()
            XCTAssertEqual(error.errorDescription, "API_ERROR")
        }

        viewModel.fetchMovies(searchedTitle: "test", forced: true)
        apiResponseSubject.send(completion: Subscribers.Completion<ApiError>.failure(.response(errorFromApi: "API_ERROR")))
        waitForExpectations(timeout: 2)
    }

    func testFetchMovies_forGeneralError() {
        let errorReturnedExpecation = expectation(description: "Error called")

        viewModel.errorHandler = { error in
            errorReturnedExpecation.fulfill()
            XCTAssertEqual(error.errorDescription, "TEST_ERROR")
        }

        viewModel.fetchMovies(searchedTitle: "test", forced: true)
        apiResponseSubject.send(completion: Subscribers.Completion<ApiError>.failure(.generalError(error: TestError.testError)))
        waitForExpectations(timeout: 2)
    }

    func testClearData_AndGenerateError() {
        // Given
        viewModel.currentMovies = [MovieMetadata(title: "title_", year: "2021", imdbID: "123", type: .movie, poster: "")]
        XCTAssertEqual(viewModel.currentMovies.count, 1)

        let emptyDataErrorReturnedExpectation = expectation(description: "Empty data error returned")
        viewModel.errorHandler = { error in
            XCTAssertTrue(error is OMDBErrorData)
            XCTAssertEqual(error as? OMDBErrorData, OMDBErrorData.emptyQuery)
            emptyDataErrorReturnedExpectation.fulfill()
        }

        // When
        viewModel.clearData(generateError: true)

        // Then
        waitForExpectations(timeout: 2.0)
        XCTAssertEqual(viewModel.currentMovies.count, 0)
        XCTAssertNil(apiServiceMock.pagination)
    }

    func testClearData_AndNotGenerateError() {
        // Given
        viewModel.currentMovies = [MovieMetadata(title: "title_", year: "2021", imdbID: "123", type: .movie, poster: "")]
        XCTAssertEqual(viewModel.currentMovies.count, 1)

        let emptyDataErrorNotReturnedExpectation = expectation(description: "Empty data not error returned")
        emptyDataErrorNotReturnedExpectation.isInverted = true

        viewModel.errorHandler = { _ in
            emptyDataErrorNotReturnedExpectation.fulfill()
        }

        // When
        viewModel.clearData(generateError: false)

        // Then
        waitForExpectations(timeout: 2.0)
        XCTAssertEqual(viewModel.currentMovies.count, 0)
        XCTAssertNil(apiServiceMock.pagination)
    }

    func testUpdateListWith_ForNoMovies() {
        viewModel.updateListWith([])
        XCTAssertEqual(viewModel.dataSource?.snapshot().numberOfSections, 0)
        XCTAssertEqual(viewModel.dataSource?.snapshot().numberOfItems, 0)
    }

    func testUpdateListWith_For5Movies() {
        let fakeMovies = (1 ... 5).map { MovieMetadata(title: "title_\($0)", year: "2021", imdbID: "123", type: .movie, poster: "") }
        viewModel.updateListWith(fakeMovies)
        XCTAssertEqual(viewModel.dataSource?.snapshot().numberOfSections, 1)
        XCTAssertEqual(viewModel.dataSource?.snapshot().numberOfItems, 5)
    }
}
