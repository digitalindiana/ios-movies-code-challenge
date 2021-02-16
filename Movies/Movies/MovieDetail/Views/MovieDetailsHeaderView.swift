//
//  MovieDetailsHeaderView.swift
//  Movies
//
//  Created by Piotr Adamczak on 16/02/2021.
//

import Foundation
import UIKit

struct MovieDetailsHeaderModel {
    var cachedPoster: UIImage?
    let title: String
    let year: String
}

class MovieDetailsHeaderView: UIView {
    var posterImageView = UIImageView()
    var labelsStackView = UIStackView()
    var movieTitleLabel = UILabel()
    var movieYearLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false

        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true

        labelsStackView.backgroundColor = UIColor(named: MovieCellColors.movieTitle.rawValue)
        labelsStackView.axis = .vertical

        movieTitleLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        movieTitleLabel.textColor = .white

        movieYearLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        movieYearLabel.textColor = .white

        addSubview(posterImageView)
        addSubview(labelsStackView)

        labelsStackView.addArrangedSubview(movieTitleLabel)
        labelsStackView.addArrangedSubview(movieYearLabel)

        let constraints = [
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            posterImageView.topAnchor.constraint(equalTo: topAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            labelsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0),
            labelsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10.0)
        ]
        NSLayoutConstraint.activate(constraints)

        fill(with: MovieDetailsHeaderModel(cachedPoster: nil, title: "", year: ""))
    }

    func fill(with model: MovieDetailsHeaderModel) {
        posterImageView.image = model.cachedPoster
        movieTitleLabel.text = model.title
        movieYearLabel.text = model.year
    }
}
