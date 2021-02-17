//
//  MovieReviewsViewController.swift
//  Movies
//
//  Created by Piotr Adamczak on 17/02/2021.
//

import UIKit

class MovieReviewsViewController: UIViewController {
    var movieReviews: [MovieReview] = []

    var viewModel: MovieReviewsViewModelProtocol? = DefaultMovieReviewsViewModel()

    var aView: MovieReviewsView {
        return view as! MovieReviewsView
    }

    override func loadView() {
        view = MovieReviewsView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(close))

        aView.tableView.register(MovieReviewCell.self, forCellReuseIdentifier: MovieReviewCell.reuseIdentifier)

        viewModel?.setupDataSource(for: aView.tableView)
        viewModel?.updateListWith(movieReviews)
    }

    @objc func close() {
        dismiss(animated: true)
    }
}
