//
//  ApiServiceMock.swift
//  MoviesTests
//
//  Created by Piotr Adamczak on 18/02/2021.
//

@testable import Movies
import Foundation

// Normally I would use the swifymocky library to create mocks
// but I can't use 3rd party libraries...
// Life is too short to create mocks manually...

class ApiServiceMock: APIServiceProtocol {
    var baseUrl: String = ""
    var pagination: Pagination?
    
    var mockedResponse: Decodable? = nil
    var mockedError: ApiError? = nil

    func performRequest<Response: Decodable, APIError: Decodable>(to endpoint: Endpoint,
                                                                  responseType: Response.Type,
                                                                  responseErrorType: APIError.Type,
                                                                  completion: @escaping ((Result<Response, ApiError>) -> ())) {
        if let mockedResponse = mockedResponse as? Response {
            completion(.success(mockedResponse))
        } else if let mockedError = mockedError {
            completion(.failure(mockedError))
        }
    }

    func performRequest<Response: Decodable>(to endpoint: Endpoint,
                                             responseType: Response.Type,
                                             completion: @escaping ((Result<Response, ApiError>) -> ())) {
        
        if let mockedResponse = mockedResponse as? Response{
            completion(.success(mockedResponse))
        }
    }
}
