//
//  MovieReviewsViewModel.swift
//  Movies
//
//  Created by Piotr Adamczak on 17/02/2021.
//

import Foundation
import UIKit

enum MovieReviewsSection {
    case reviews
}

typealias MovieReviewsDataSource = UITableViewDiffableDataSource<MovieReviewsSection, MovieReview>
typealias MovieReviewsDataSnapshot = NSDiffableDataSourceSnapshot<MovieReviewsSection, MovieReview>

protocol MovieReviewsViewModelProtocol {
    // DataSource for collection view diffable data source
    var dataSource: MovieReviewsDataSource? { get }

    var currentReviews: [MovieReview] { get }

    // Setting up the data source for table view
    func setupDataSource(for tableView: UITableView)
    func updateListWith(_ movieReviews: [MovieReview])
    func clearData()
}

class DefaultMovieReviewsViewModel: NSObject, MovieReviewsViewModelProtocol {
    var dataSource: MovieReviewsDataSource?

    var currentReviews: [MovieReview] = []

    /// Setup of UITableViewDiffableDataSource
    /// - Parameter tableView: UITableView
    func setupDataSource(for tableView: UITableView) {
        dataSource = UITableViewDiffableDataSource(tableView: tableView,
                                                   cellProvider: { (tableView, indexPath, review) -> UITableViewCell? in

            if let cell = tableView.dequeueReusableCell(withIdentifier: MovieReviewCell.reuseIdentifier, for: indexPath) as? MovieReviewCell {
                cell.titleLabel.text = review.displayTitle
                cell.reviewLabel.text = review.summaryShort
                return cell
            }

            return UITableViewCell()
        })
    }

    /// Updates the list with given reviews list
    /// - Parameter movieReviews: [MovieReview]
    func updateListWith(_ movieReviews: [MovieReview]) {
        var snapshot = MovieReviewsDataSnapshot()
        currentReviews = movieReviews
        if movieReviews.count == 0 {
            snapshot.deleteAllItems()
        } else {
            snapshot.appendSections([.reviews])
            snapshot.appendItems(movieReviews)
        }
        dataSource?.apply(snapshot, animatingDifferences: false)
    }

    func clearData() {
        updateListWith([])
    }
}
