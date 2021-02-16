//
//  MovieListCell.swift
//  Movies
//
//  Created by Piotr Adamczak on 16/02/2021.
//

import Foundation
import UIKit

enum MovieCellColors: String {
    case cellBackground = "MovieListCellBackground"
    case movieTitle = "MovieTitleCellBackground"
}

class MovieListCell: UICollectionViewCell {
    static var reuseIdentifier: String {
        return "MovieListCellIdentifier"
    }

    var posterImageView = UIImageView()
    var movieTitleBackground = UIView()
    var movieTitleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        movieTitleBackground.translatesAutoresizingMaskIntoConstraints = false

        contentView.backgroundColor = UIColor(named: MovieCellColors.cellBackground.rawValue)
        posterImageView.contentMode = .scaleAspectFit
        movieTitleBackground.backgroundColor = UIColor(named: MovieCellColors.movieTitle.rawValue)

        movieTitleLabel.numberOfLines = 2
        movieTitleLabel.adjustsFontSizeToFitWidth = true
        movieTitleLabel.minimumScaleFactor = 0.5
        movieTitleLabel.textColor = .white

        contentView.addSubview(posterImageView)
        contentView.addSubview(movieTitleBackground)
        contentView.addSubview(movieTitleLabel)

        let movieTitleMargin = CGFloat(2)

        let constraints = [
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            movieTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: movieTitleMargin),
            movieTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: movieTitleMargin),
            movieTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: movieTitleMargin),
            movieTitleBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieTitleBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieTitleBackground.topAnchor.constraint(equalTo: movieTitleLabel.topAnchor),
            movieTitleBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 5
    }
}
