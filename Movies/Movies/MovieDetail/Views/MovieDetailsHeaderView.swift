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
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var movieYearLabel: UILabel!
    @IBOutlet var playButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()

        fill(with: MovieDetailsHeaderModel(cachedPoster: nil, title: "", year: ""))
    }

    func fill(with model: MovieDetailsHeaderModel) {
        posterImageView.image = model.cachedPoster
        movieTitleLabel.text = model.title
        movieYearLabel.text = model.year
    }
}
