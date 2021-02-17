//
//  OMDBApiService.swift
//  Movies
//
//  Created by Piotr Adamczak on 16/02/2021.
//

import Foundation

enum NYTimesApiParameter: String {
    case apiKey = "api-key"
    case searchedTitle = "query"

    func queryItem(for value: String) -> URLQueryItem {
        return URLQueryItem(name: rawValue, value: value)
    }
}

enum NYTApiEndpoint: Endpoint {
    case movieReviews(searchedTitle: String)

    var path: String {
        return "/svc/movies/v2/reviews/search.json"
    }

    var queryItems: [URLQueryItem] {
        switch self {
        case let .movieReviews(searchedTitle: searchedTitle):
                return [apiKeyQueryItem,
                        NYTimesApiParameter.searchedTitle.queryItem(for: searchedTitle)]
        }
    }

    // Required api key query item
    var apiKeyQueryItem: URLQueryItem {
        return URLQueryItem(name: NYTimesApiParameter.apiKey.rawValue, value: NYTimesApiService.apiKey)
    }
}

enum NYTimesErrorData: ErrorData, Equatable {
    case unauthorizedRequest
    case noInternet
    case error(errorDescription: String)

    var imageName: String {
        "icon_error"
    }

    var errorDescription: String {
        switch self {
            case .unauthorizedRequest:
                return NSLocalizedString("Unauthorized request..", comment: "")
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

class NYTimesApiService: APIServiceProtocol {
    fileprivate static var apiKey = "yiZ7FEbUdA6Uybv9DqVRzYOGaNi1mi7u"
    var baseUrl: String = "https://api.nytimes.com"
    var pagination: Pagination?
}
