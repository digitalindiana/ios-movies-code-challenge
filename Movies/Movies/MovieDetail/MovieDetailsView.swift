//
//  MovieDetailsView.swift
//  Movies
//
//  Created by Piotr Adamczak on 16/02/2021.
//

import Foundation
import UIKit

class MovieDetailsView: UIView {
    var scrollView = UIScrollView()
    var contentStackView = UIStackView()
    var errorView = ErrorView()

    var headerView = MovieDetailsHeaderView()
    var generalInfoView = MovieDetailsGeneralInfoView()
    var castInfoView = MovieDetailsCastInfoView()

    var activitySpinner = UIActivityIndicatorView(style: .large)

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        backgroundColor = .systemBackground

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        errorView.translatesAutoresizingMaskIntoConstraints = false
        headerView.translatesAutoresizingMaskIntoConstraints = false
        generalInfoView.translatesAutoresizingMaskIntoConstraints = false
        castInfoView.translatesAutoresizingMaskIntoConstraints = false
        activitySpinner.translatesAutoresizingMaskIntoConstraints = false

        scrollView.addSubview(contentStackView)
        scrollView.addSubview(activitySpinner)
        addSubview(scrollView)
        addSubview(errorView)

        contentStackView.addArrangedSubview(headerView)
        contentStackView.addArrangedSubview(generalInfoView)
        contentStackView.addArrangedSubview(castInfoView)
        contentStackView.addArrangedSubview(UIView())
        
        contentStackView.axis = .vertical
        contentStackView.backgroundColor = .clear

        activitySpinner.isHidden = true
      
        let constraints = [
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            errorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            errorView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            errorView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            headerView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.33),
            activitySpinner.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            activitySpinner.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    func showActivityView() {
        activitySpinner.startAnimating()
    }

    func hideActivityView() {
        activitySpinner.stopAnimating()
    }
}
