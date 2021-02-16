//
//  MovieDetailsHeaderView.swift
//  Movies
//
//  Created by Piotr Adamczak on 15/01/2021.
//

import Foundation
import UIKit

struct MovieDetailsHeaderModel {
    var posterImageUrl: URL?
    let title: String
    let year: String
}

class MovieDetailsHeaderView: UIView {
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var movieYearLabel: UILabel!
    @IBOutlet var playButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()

        fill(with: MovieDetailsHeaderModel(posterImageUrl: nil, title: "", year: ""))
    }

    func fill(with model: MovieDetailsHeaderModel) {
        posterImageView.sd_setImage(with: model.posterImageUrl)
        movieTitleLabel.text = model.title
        movieYearLabel.text = model.year
    }
}
