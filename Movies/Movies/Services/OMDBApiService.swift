//
//  OMDBApiService.swift
//  Movies
//
//  Created by Piotr Adamczak on 16/02/2021.
//

import Foundation

enum OMDBApiParameter: String {
    case apiKey = "apikey"
    case searchedTitle = "s"
    case item = "i"
    case page, type

    func queryItem(for value: String) -> URLQueryItem {
        return URLQueryItem(name: rawValue, value: value)
    }
}

struct OMDBApiResponseError: APIResponseError {
    let error: String

    enum CodingKeys: String, CodingKey {
        case error = "Error"
    }
}

enum OMDBApiEndpoint: Endpoint {
    case moviesList(searchedTitle: String, page: Int)
    case movieDetail(imdbID: String)

    var path: String {
        return ""
    }

    var queryItems: [URLQueryItem] {
        switch self {
            case let .moviesList(searchedTitle: searchedTitle, page: page):
                return [apiKeyQueryItem,
                        OMDBApiParameter.type.queryItem(for: MediaType.movie.rawValue),
                        OMDBApiParameter.searchedTitle.queryItem(for: searchedTitle),
                        OMDBApiParameter.page.queryItem(for: "\(page)")]

            case let .movieDetail(imdbID: imdbId):
                return [apiKeyQueryItem,
                        OMDBApiParameter.item.queryItem(for: imdbId)]
        }
    }

    // Required api key query item
    var apiKeyQueryItem: URLQueryItem {
        return URLQueryItem(name: OMDBApiParameter.apiKey.rawValue, value: OMDBApiService.apiKey)
    }
}

enum OMDBErrorData: ErrorData, Equatable {
    case emptyQuery
    case noInternet
    case error(errorDescription: String)

    var imageName: String {
        switch self {
            case .emptyQuery:
                return "icon_no_data"
            case .noInternet:
                return "icon_no_internet"
            case .error:
                return "icon_error"
        }
    }

    var errorDescription: String {
        switch self {
            case .emptyQuery:
                return NSLocalizedString("Type at least 3 characters to start search..", comment: "Empty data info")
            case .noInternet:
                return NSLocalizedString("Check Internet connection and try again", comment: "No Internet Connection")
            case let .error(errorDescription: errorDescription):
                return errorDescription
        }
    }

    init(apiError: ApiError) {
        switch apiError {
            case ApiError.noInternet:
                self = .noInternet
            case let ApiError.generalError(error: error):
                self = .error(errorDescription: error.localizedDescription)
            case let ApiError.response(errorFromApi: errorFromApi):
                self = .error(errorDescription: errorFromApi)
            case ApiError.wrongUrl:
                self = .error(errorDescription: NSLocalizedString("Wrong URL", comment: "Wrong URL"))
        }
    }
}

struct DefaultPagination: Pagination {
    var queryItem: String = ""
    // omdbapi starts pagination from 1 - not from 0..
    // "Error": "The offset specified in a OFFSET clause may not be negative."
    var currentPage: Int = 1
    var savedItems: Int = 0
    var totalItems: Int = 0
    var dataUpdated: Bool = false

    func update(savedItems: Int, totalItems: Int) -> Pagination {
        return DefaultPagination(queryItem: queryItem,
                                 currentPage: currentPage,
                                 savedItems: savedItems,
                                 totalItems: totalItems,
                                 dataUpdated: true)
    }

    func nextPagination() -> Pagination {
        return DefaultPagination(queryItem: queryItem,
                                 currentPage: currentPage + 1,
                                 savedItems: savedItems,
                                 totalItems: totalItems,
                                 dataUpdated: false)
    }
}

class OMDBApiService: APIServiceProtocol {
    fileprivate static var apiKey = "515b2c9e"
    var baseUrl: String = "http://www.omdbapi.com"
    var pagination: Pagination?
}
