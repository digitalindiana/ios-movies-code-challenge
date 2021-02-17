//
//  MovieReviewsModel.swift
//  Movies
//
//  Created by Piotr Adamczak on 17/02/2021.
//

import Foundation

// MARK: - MovieReviewsResponse
struct MovieReviewsResponse: Codable {
    let status, copyright: String
    let hasMore: Bool
    let numResults: Int
    let results: [MovieReview]

    enum CodingKeys: String, CodingKey {
        case status, copyright
        case hasMore = "has_more"
        case numResults = "num_results"
        case results
    }
}

// MARK: - MovieReview
struct MovieReview: Codable {
    let uuid = UUID()
    let displayTitle, byline, summaryShort: String

    enum CodingKeys: String, CodingKey {
        case displayTitle = "display_title"
        case byline
        case summaryShort = "summary_short"
    }
}

extension MovieReview: Hashable {
    static func == (lhs: MovieReview, rhs: MovieReview) -> Bool {
        return lhs.uuid == rhs.uuid
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
