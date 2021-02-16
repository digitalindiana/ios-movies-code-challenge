//
//  MovieDetailsViewController.swift
//  Movies
//
//  Created by Piotr Adamczak on 15/01/2021.
//

import UIKit

class MovieDetailsSegue: UIStoryboardSegue {
    static var identifier = "MovieDetailsSeque"
}

class MovieDetailsViewController: UIViewController {
    var imdbId: String?

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var contentStackView: UIStackView!
    @IBOutlet var headerView: MovieDetailsHeaderView!
    @IBOutlet var generalInfoView: MovieDetailsGeneralInfoView!
    @IBOutlet var castInfoView: MovieDetailsCastInfoView!
    @IBOutlet var errorView: ErrorView!

    var viewModel: MovieDetailViewModelProtocol? = DefaultMovieDetailsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("Movie details", comment: "Movie details")
        navigationItem.largeTitleDisplayMode = .never

        headerView.playButton.addTarget(self,
                                        action: #selector(MovieDetailsViewController.playButtonTapped(sender:)),
                                        for: .touchUpInside)

        configureHandlers()

        if let imdbId = imdbId {
            viewModel?.fetchMovie(imdbID: imdbId)
        }
    }

    func configureHandlers() {
        errorView.isHidden = true
        viewModel?.errorHandler = { errorData in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.errorView.isHidden = false
                self.contentStackView.isHidden = true
                self.errorView.show(errorData)
            }
        }

        viewModel?.movieLoaded = { [weak self] viewData in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.errorView.isHidden = true
                self.contentStackView.isHidden = false
                self.headerView.fill(with: viewData.header)
                self.generalInfoView.fill(with: viewData.general)
                self.castInfoView.fill(with: viewData.cast)
            }
        }
    }

    @objc func playButtonTapped(sender: UIButton) {
        let alert = UIAlertController(title: NSLocalizedString("Warning ⚠️", comment: ""),
                                      message: NSLocalizedString("Playback not supported 😥", comment: ""),
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Okay..", comment: ""),
                                      style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
