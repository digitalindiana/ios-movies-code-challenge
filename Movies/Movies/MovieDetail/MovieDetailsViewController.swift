//
//  MovieDetailsViewController.swift
//  Movies
//
//  Created by Piotr Adamczak on 16/02/2021.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    var movieMetadata: MovieMetadata?

    var viewModel: MovieDetailViewModelProtocol? = DefaultMovieDetailsViewModel()

    var aView: MovieDetailsView {
        return view as! MovieDetailsView
    }

    override func loadView() {
        view = MovieDetailsView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("Movie details", comment: "Movie details")
        navigationItem.largeTitleDisplayMode = .never

        configureHandlers()

        if let movieMetadata = movieMetadata {
            viewModel?.fetchMovie(movieMetadata: movieMetadata)
            viewModel?.fetchReviews(movieMetadata: movieMetadata)
        }
    }

    func configureHandlers() {
        aView.errorView.isHidden = true
        viewModel?.errorHandler = { errorData in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.aView.errorView.isHidden = false
                self.aView.contentStackView.isHidden = true
                self.aView.errorView.show(errorData)
            }
        }

        viewModel?.movieLoaded = { [weak self] viewData in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.aView.errorView.isHidden = true
                self.aView.contentStackView.isHidden = false
                self.aView.headerView.fill(with: viewData.header)
                self.aView.generalInfoView.fill(with: viewData.general)
                self.aView.castInfoView.fill(with: viewData.cast)
            }
        }

        viewModel?.reviewsLoaded = { [weak self] reviews in
            DispatchQueue.main.async { [weak self] in
                let reviewsVC = MovieReviewsViewController()
                reviewsVC.movieReviews = reviews
                reviewsVC.title = String(format: NSLocalizedString("Reviews of: %@", comment: ""), self?.movieMetadata?.title ?? "")
                let navigationVC = UINavigationController(rootViewController: reviewsVC)
                self?.present(navigationVC, animated: true)
            }
        }
    }
}
