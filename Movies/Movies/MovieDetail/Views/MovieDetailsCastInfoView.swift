//
//  MovieDetailsGeneralInfoView.swift
//  Movies
//
//  Created by Piotr Adamczak on 15/01/2021.
//

import Foundation
import UIKit

struct MovieDetailsCastInfoModel {
    var director: String
    var writer: String
    var actors: String
}

class MovieDetailsCastInfoView: UIView {
    @IBOutlet var directorLabel: UILabel!
    @IBOutlet var directorValueLabel: UILabel!

    @IBOutlet var writerLabel: UILabel!
    @IBOutlet var writerValueLabel: UILabel!

    @IBOutlet var actorsLabel: UILabel!
    @IBOutlet var actorsValueLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        directorLabel.text = NSLocalizedString("Director", comment: "")
        writerLabel.text = NSLocalizedString("Writer", comment: "")
        actorsLabel.text = NSLocalizedString("Actors", comment: "")
        fill(with: MovieDetailsCastInfoModel(director: "", writer: "", actors: ""))
    }

    func fill(with model: MovieDetailsCastInfoModel) {
        directorValueLabel.text = model.director
        writerValueLabel.text = model.writer
        actorsValueLabel.text = model.actors
    }
}
