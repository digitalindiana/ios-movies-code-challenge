//
//  MovieDetailsGeneralInfoView.swift
//  Movies
//
//  Created by Piotr Adamczak on 16/02/2021.
//

import Foundation
import UIKit

struct MovieDetailsGeneralInfoModel {
    var categories: String
    var duration: String
    var rating: String
    var synopsis: String
    var score: String
    var reviews: String
    var popularity: String
}

class MovieDetailsGeneralInfoView: UIView {

    var mainStackView = UIStackView()

    var topStackView = UIStackView()
    var categoriesLabel = UILabel()
    var durationLabel = UILabel()
    var ratingLabel = UILabel()

    var synopsisTitleLabel = UILabel()
    var synopsisValueLabel = UILabel()

    var statsStackView = UIStackView()

    var scoreStackView = UIStackView()
    var scoreLabel = UILabel()
    var scoreValueLabel = UILabel()

    var reviewsStackView = UIStackView()
    var reviewsLabel = UILabel()
    var reviewsValueLabel = UILabel()

    var popularityStackView = UIStackView()
    var popularityLabel = UILabel()
    var popularityValueLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {

        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        scoreStackView.translatesAutoresizingMaskIntoConstraints = false
        reviewsStackView.translatesAutoresizingMaskIntoConstraints = false
        popularityStackView.translatesAutoresizingMaskIntoConstraints = false
        statsStackView.translatesAutoresizingMaskIntoConstraints = false

        topStackView.addArrangedSubview(categoriesLabel)
        topStackView.addArrangedSubview(durationLabel)
        topStackView.addArrangedSubview(ratingLabel)
        topStackView.axis = .horizontal
        topStackView.alignment = .center

        durationLabel.textAlignment = .center
        ratingLabel.textAlignment = .center

        mainStackView.addArrangedSubview(topStackView)

        mainStackView.addArrangedSubview(synopsisTitleLabel)
        mainStackView.addArrangedSubview(synopsisValueLabel)

        scoreStackView.addArrangedSubview(scoreLabel)
        scoreStackView.addArrangedSubview(scoreValueLabel)
        scoreStackView.spacing = 5
        scoreStackView.axis = .vertical
        scoreStackView.alignment = .center

        reviewsStackView.addArrangedSubview(reviewsLabel)
        reviewsStackView.addArrangedSubview(reviewsValueLabel)
        reviewsStackView.spacing = 5
        reviewsStackView.axis = .vertical
        reviewsStackView.alignment = .center

        popularityStackView.addArrangedSubview(popularityLabel)
        popularityStackView.addArrangedSubview(popularityValueLabel)
        popularityStackView.spacing = 5
        popularityStackView.axis = .vertical
        popularityStackView.alignment = .center

        statsStackView.addArrangedSubview(scoreStackView)
        statsStackView.addArrangedSubview(reviewsStackView)
        statsStackView.addArrangedSubview(popularityStackView)
        statsStackView.axis = .horizontal
        statsStackView.alignment = .center
        statsStackView.distribution = .fillEqually
        mainStackView.addArrangedSubview(statsStackView)

        mainStackView.axis = .vertical
        mainStackView.spacing = 10
        mainStackView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        mainStackView.isLayoutMarginsRelativeArrangement = true

        addSubview(mainStackView)

        let allTitleLabels = [synopsisTitleLabel, scoreLabel, reviewsLabel, popularityLabel]
        allTitleLabels.forEach { (label) in
            apply(textStyle: .subheadline, for: label)
        }

        let allBodyLabel = [categoriesLabel, durationLabel, ratingLabel, synopsisValueLabel, scoreValueLabel, reviewsValueLabel,  popularityValueLabel]
        allBodyLabel.forEach { (label) in
            apply(textStyle: .body, for: label)
        }

        let constraints = [
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)

        synopsisTitleLabel.text = NSLocalizedString("Synopsis", comment: "")
        scoreLabel.text = NSLocalizedString("Score", comment: "")
        reviewsLabel.text = NSLocalizedString("Reviews", comment: "")
        popularityLabel.text = NSLocalizedString("Popularity", comment: "")
        fill(with: MovieDetailsGeneralInfoModel(categories: "", duration: "", rating: "", synopsis: "", score: "", reviews: "", popularity: ""))
    }

    func apply(textStyle: UIFont.TextStyle, for label: UILabel) {
        label.font = UIFont.preferredFont(forTextStyle: textStyle)
        label.textColor = .black
        label.numberOfLines = 0
    }

    func fill(with model: MovieDetailsGeneralInfoModel) {
        categoriesLabel.text = model.categories
        durationLabel.text = model.duration
        ratingLabel.text = model.rating
        synopsisValueLabel.text = model.synopsis
        scoreValueLabel.text = model.score
        reviewsValueLabel.text = model.reviews
        popularityValueLabel.text = model.popularity
    }
}
