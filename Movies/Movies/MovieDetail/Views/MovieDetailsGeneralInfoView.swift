//
//  MovieDetailsGeneralInfoView.swift
//  Movies
//
//  Created by Piotr Adamczak on 15/01/2021.
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
    @IBOutlet var categoriesLabel: UILabel!
    @IBOutlet var durationLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!

    @IBOutlet var synopsisTitleLabel: UILabel!
    @IBOutlet var synopsisValueLabel: UILabel!

    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var scoreValueLabel: UILabel!

    @IBOutlet var reviewsLabel: UILabel!
    @IBOutlet var reviewsValueLabel: UILabel!

    @IBOutlet var popularityLabel: UILabel!
    @IBOutlet var popularityValueLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        synopsisTitleLabel.text = NSLocalizedString("Synopsis", comment: "")
        scoreLabel.text = NSLocalizedString("Score", comment: "")
        reviewsLabel.text = NSLocalizedString("Reviews", comment: "")
        popularityLabel.text = NSLocalizedString("Popularity", comment: "")
        fill(with: MovieDetailsGeneralInfoModel(categories: "", duration: "", rating: "", synopsis: "", score: "", reviews: "", popularity: ""))
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
