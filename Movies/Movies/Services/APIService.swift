//
//  APIService.swift
//  Movies
//
//  Created by Piotr Adamczak on 16/02/2021.
//

import Foundation

enum ApiError: Error {
    case wrongUrl
    case noInternet
    case response(errorFromApi: String)
    case generalError(error: Error)
}

protocol Endpoint {
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
}

protocol APIResponseError: Decodable {
    var error: String { get }
}

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

protocol APIServiceProtocol {
    var baseUrl: String { get }
    var pagination: Pagination? { get set }
    func fullUrl(for endpoint: Endpoint) -> URL?
    func performRequest<Response: Decodable, APIError: Decodable>(to endpoint: Endpoint,
                                                                  responseType: Response.Type,
                                                                  responseErrorType: APIError.Type,
                                                                  completion: @escaping ((Result<Response, ApiError>) -> ()))

    func performRequest<Response: Decodable>(to endpoint: Endpoint,
                                             responseType: Response.Type,
                                             completion: @escaping ((Result<Response, ApiError>) -> ()))
}

extension APIServiceProtocol {
    func fullUrl(for endpoint: Endpoint) -> URL? {
        var urlComponents = URLComponents(string: baseUrl)
        urlComponents?.path = endpoint.path
        urlComponents?.queryItems = endpoint.queryItems
        return urlComponents?.url
    }

    /// Perform request which tries to decode JSON into Response object
    /// If it would be impossible - core error would be returned wrapped as ApiError
    /// - Parameters:
    ///   - endpoint: Endpoint struct which defines things like path.
    ///   - responseType: Class used to decode JSON response in case of success
    ///   - completion: Block returning the result of type Response and ApiError
    func performRequest<Response: Decodable>(to endpoint: Endpoint,
                                             responseType: Response.Type,
                                            completion: @escaping ((Result<Response, ApiError>) -> ())) {

        guard let url = fullUrl(for: endpoint) else {
            return completion(.failure(ApiError.wrongUrl))
        }

        URLSession.shared.dataTask(with: url) { data, response, error in

            if let urlError = error as? URLError,
               urlError.code == URLError.notConnectedToInternet {
                    completion(.failure(ApiError.noInternet))
                    return
            }

            if let error = error {
                completion(.failure(ApiError.generalError(error: error)))
                return
            }

            if let data = data {

                do {
                    let responseObject = try JSONDecoder().decode(Response.self, from: data)
                    completion(.success(responseObject))
                }
                catch let parseError {
                    completion(.failure(ApiError.generalError(error: parseError)))
                }
            }
        }.resume()
    }

    /// Perform request which tries to decode JSON into Response object
    /// In failure case it will try to parse APIError JSON format response
    /// If it would be impossible - core error would be returned wrapped as ApiError
    /// - Parameters:
    ///   - endpoint: Endpoint struct which defines things like path.
    ///   - responseType: Class used to decode JSON response in case of success
    ///   - responseErrorType: Class used to decode JSON in case of API error
    ///   - completion: Block returning the result of type Response and ApiError
    func performRequest<Response: Decodable, APIError: Decodable>(to endpoint: Endpoint,
                                                                  responseType: Response.Type,
                                                                  responseErrorType: APIError.Type,
                                                                  completion: @escaping ((Result<Response, ApiError>) -> ())) {
        guard let url = fullUrl(for: endpoint) else {
            return completion(.failure(ApiError.wrongUrl))
        }

        URLSession.shared.dataTask(with: url) { data, response, error in

            if let urlError = error as? URLError,
               urlError.code == URLError.notConnectedToInternet {
                    completion(.failure(ApiError.noInternet))
                    return
            }

            if let error = error {
                completion(.failure(ApiError.generalError(error: error)))
                return
            }

            if let data = data {

                do {
                    let responseObject = try JSONDecoder().decode(Response.self, from: data)
                    completion(.success(responseObject))
                }
                catch let parseError {

                    if let errorResponse = try? JSONDecoder().decode(APIError.self, from: data) as? APIResponseError {
                        completion(.failure(ApiError.response(errorFromApi: errorResponse.error)))
                        return
                    }

                    completion(.failure(ApiError.generalError(error: parseError)))
                }
            }
        }.resume()
    }
}
