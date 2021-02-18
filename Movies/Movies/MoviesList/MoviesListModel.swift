//
//  MoviesListModel.swift
//  Movies
//
//  Created by Piotr Adamczak on 16/02/2021.
//

import Foundation
import UIKit

// MARK: - MoviesListResponse

struct MoviesListResponse: Codable {
    let movies: [MovieMetadata]
    let totalResults: String
    let response: String

    enum CodingKeys: String, CodingKey {
        case movies = "Search"
        case totalResults
        case response = "Response"
    }
}

// MARK: - Movie

class MovieMetadata: Codable {
    let uuid = UUID()
    let title: String
    let year: String
    let imdbID: String
    let type: MediaType
    let poster: String
    var cachedPoster: UIImage? = nil

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }

    init(imdbID: String, title: String = "", year: String = "", type: MediaType = .movie, poster: String = "") {
        self.imdbID = imdbID
        self.title = title
        self.year = year
        self.poster = poster
        self.type = type
    }
}

extension MovieMetadata: Hashable {
    static func == (lhs: MovieMetadata, rhs: MovieMetadata) -> Bool {
        return lhs.uuid == rhs.uuid
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}

enum MediaType: String, Codable {
    case movie
    case game
}
