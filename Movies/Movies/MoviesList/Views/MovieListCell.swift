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

    var itemIdentifier: String = ""
    var posterImageView = UIImageView()
    var movieTitleBackground = UIView()
    var movieTitleLabel = UILabel()
    private var favouriteButton = UIButton()

    var favouriteTappedAction: ((String) -> Void)?

    var isFavourite: Bool = false {
        didSet {
            let imageName = isFavourite ? "icon_favourite" : "icon_non_favourite"
            favouriteButton.setImage(UIImage(named: imageName), for: .normal)
        }
    }

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
        favouriteButton.translatesAutoresizingMaskIntoConstraints = false

        contentView.backgroundColor = UIColor(named: MovieCellColors.cellBackground.rawValue)
        posterImageView.contentMode = .scaleAspectFit
        movieTitleBackground.backgroundColor = UIColor(named: MovieCellColors.movieTitle.rawValue)

        movieTitleLabel.numberOfLines = 2
        movieTitleLabel.adjustsFontSizeToFitWidth = true
        movieTitleLabel.minimumScaleFactor = 0.5
        movieTitleLabel.textColor = .white

        favouriteButton.addTarget(self, action: #selector(MovieListCell.favouriteButtonTap(sender:)), for: .touchUpInside)
        favouriteButton.imageEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        favouriteButton.backgroundColor = UIColor.white.withAlphaComponent(0.8)

        contentView.addSubview(posterImageView)
        contentView.addSubview(movieTitleBackground)
        contentView.addSubview(movieTitleLabel)
        contentView.addSubview(favouriteButton)

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
            movieTitleBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            favouriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            favouriteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            favouriteButton.widthAnchor.constraint(equalToConstant: 30),
            favouriteButton.heightAnchor.constraint(equalToConstant: 30)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 5

        favouriteButton.clipsToBounds = true
        favouriteButton.layer.cornerRadius = 5
    }

    @objc func favouriteButtonTap(sender: AnyObject) {
        favouriteTappedAction?(itemIdentifier)
    }
}
