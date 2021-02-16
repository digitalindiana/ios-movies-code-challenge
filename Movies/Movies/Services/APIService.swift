//
//  APIService.swift
//  Movies
//
//  Created by Piotr Adamczak on 13/01/2021.
//

import Combine
import Foundation

enum ApiError: Error {
    case wrongUrl
    case noInternet
    case response(errorFromApi: String)
    case generalError(error: Error)
}

// sourcery: AutoMockable
protocol Endpoint {
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
}

protocol APIResponseError: Decodable {
    var error: String { get }
}

// sourcery: AutoMockable
protocol Pagination {
    var queryItem: String { get }
    var currentPage: Int { get }
    var savedItems: Int { get }
    var totalItems: Int { get }
    var dataUpdated: Bool { get }

    func update(savedItems: Int, totalItems: Int) -> Pagination
    func hasMoreData() -> Bool
    func nextPagination() -> Pagination
}

extension Pagination {
    func hasMoreData() -> Bool {
        let firstRun = (!dataUpdated && savedItems == 0)
        let gotAllElements = savedItems < totalItems
        return firstRun || gotAllElements
    }
}

// sourcery: AutoMockable
protocol APIServiceProtocol {
    var baseUrl: String { get }
    var pagination: Pagination? { get set }
    func fullUrl(for endpoint: Endpoint) -> URL?
    func performRequest<Response: Decodable, APIError: Decodable>(to endpoint: Endpoint, responseErrorType: APIError.Type) -> AnyPublisher<Response, ApiError>?
}

extension APIServiceProtocol {
    func fullUrl(for endpoint: Endpoint) -> URL? {
        var urlComponents = URLComponents(string: baseUrl)
        urlComponents?.path = endpoint.path
        urlComponents?.queryItems = endpoint.queryItems
        return urlComponents?.url
    }

    /// Perform request which tries to decode JSON into Response object
    /// In failure case it will try to parse APIError JSON format response
    /// If it would be impossible - core error would be returned wrapped as ApiError
    /// - Parameters:
    ///   - endpoint: Endpoint struct which defines things like path.
    ///   - responseErrorType: Class used to decode JSON in case of API error
    /// - Returns: Publisher with given generic Response type and ApiError
    func performRequest<Response: Decodable, APIError: Decodable>(to endpoint: Endpoint, responseErrorType: APIError.Type) -> AnyPublisher<Response, ApiError>? {
        guard let url = fullUrl(for: endpoint) else {
            return Fail(error: ApiError.wrongUrl).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .mapError {
                if $0.code == URLError.notConnectedToInternet {
                    return ApiError.noInternet
                }
                return ApiError.generalError(error: $0)
            }
            .map { $0.data }
            .flatMap { data -> AnyPublisher<Response, ApiError> in
                Just(data)
                    .decode(type: Response.self, decoder: JSONDecoder())
                    .mapError({ (error) -> ApiError in

                        if let errorResponse = try? JSONDecoder().decode(APIError.self, from: data) as? APIResponseError {
                            return ApiError.response(errorFromApi: errorResponse.error)
                        }

                        return ApiError.generalError(error: error)
                    })
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
