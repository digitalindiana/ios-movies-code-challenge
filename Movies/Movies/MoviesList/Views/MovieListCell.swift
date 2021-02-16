//
//  MovieListCell.swift
//  Movies
//
//  Created by Piotr Adamczak on 13/01/2021.
//

import Foundation
import UIKit

class MovieListCell: UICollectionViewCell {
    static var reuseIdentifier: String {
        return "MovieListCellIdentifier"
    }

    @IBOutlet var posterImageView: UIImageView?
    @IBOutlet var movieTitleLabel: UILabel?

    override func awakeFromNib() {
        layer.cornerRadius = 5

        movieTitleLabel?.adjustsFontSizeToFitWidth = true
        movieTitleLabel?.minimumScaleFactor = 0.5
    }
}
