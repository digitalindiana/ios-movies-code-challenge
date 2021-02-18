//
//  MovieDetailsViewController.swift
//  Movies
//
//  Created by Piotr Adamczak on 16/02/2021.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    var movieMetadata: MovieMetadata?

    var reviewsButton: UIBarButtonItem?

    var viewModel: MovieDetailViewModelProtocol? = DefaultMovieDetailsViewModel()

    var aView: MovieDetailsView {
        return view as! MovieDetailsView
    }

    let requestsGroup = DispatchGroup()

    override func loadView() {
        view = MovieDetailsView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("Movie details", comment: "Movie details")
        reviewsButton = UIBarButtonItem(title: "NYT Reviews",
                                        style: .plain,
                                        target: self,
                                        action: #selector(MovieDetailsViewController.presentNYTReviews))

        navigationItem.rightBarButtonItem = reviewsButton
        navigationItem.largeTitleDisplayMode = .never

        aView.generalInfoView.isHidden = true
        aView.castInfoView.isHidden = true
        reviewsButton?.isEnabled = false

        if let movieMetadata = movieMetadata {
            aView.contentStackView.isHidden = false
            aView.headerView.posterImageView.image = movieMetadata.cachedPoster

            aView.showActivityView()

            requestsGroup.enter()
            viewModel?.fetchMovie(movieMetadata: movieMetadata)

            requestsGroup.enter()
            viewModel?.fetchReviews(movieMetadata: movieMetadata)
        }

        configureHandlers()
    }

    func configureHandlers() {
        aView.errorView.isHidden = true

        viewModel?.errorHandler = { errorData in
            self.requestsGroup.leave()
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.aView.errorView.isHidden = false
                self.aView.contentStackView.isHidden = true
                self.aView.errorView.show(errorData)
            }
        }

        viewModel?.reviewsErrorHandler = { errorData in
            self.requestsGroup.leave()
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.reviewsButton?.isEnabled = false

                let alertVC = UIAlertController(title: NSLocalizedString("Reviews error..", comment: ""),
                                                message: errorData.errorDescription,
                                                preferredStyle: .alert)
                alertVC.addAction(.init(title: NSLocalizedString("Okay..", comment: ""), style: .default, handler: nil))
                self.present(alertVC, animated: true)
            }
        }

        viewModel?.movieLoaded = { [weak self] _ in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.fulfillViewWithMovieData()
            }
            self.requestsGroup.leave()
        }

        viewModel?.reviewsLoaded = { [weak self] _ in
            guard let self = self else { return }
            self.requestsGroup.leave()
            DispatchQueue.main.async {
                self.reviewsButton?.isEnabled = true
            }
        }

        requestsGroup.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            LoggerService.shared.debug("Got all data")
            self.aView.hideActivityView()
        }
    }

    func fulfillViewWithMovieData() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self, let viewData = self.viewModel?.movieData else { return }
            self.aView.errorView.isHidden = true
            self.aView.contentStackView.isHidden = false
            self.aView.generalInfoView.isHidden = false
            self.aView.castInfoView.isHidden = false
            self.aView.headerView.fill(with: viewData.header)
            self.aView.generalInfoView.fill(with: viewData.general)
            self.aView.castInfoView.fill(with: viewData.cast)
        }
    }

    @objc func presentNYTReviews() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self, let reviews = self.viewModel?.reviews else { return }
            let reviewsVC = MovieReviewsViewController()
            reviewsVC.movieReviews = reviews
            reviewsVC.title = String(format: NSLocalizedString("Reviews of: %@", comment: ""), self.movieMetadata?.title ?? "")
            let navigationVC = UINavigationController(rootViewController: reviewsVC)
            self.present(navigationVC, animated: true)
        }
    }
}
