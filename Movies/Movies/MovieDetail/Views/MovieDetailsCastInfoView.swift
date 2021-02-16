//
//  MovieDetailsGeneralInfoView.swift
//  Movies
//
//  Created by Piotr Adamczak on 16/02/2021.
//

import Foundation
import UIKit

struct MovieDetailsCastInfoModel {
    var director: String
    var writer: String
    var actors: String
}

class MovieDetailsCastInfoView: UIView {
    
    var mainStackView = UIStackView()

    var directorStackView = UIStackView()
    var directorLabel = UILabel()
    var directorValueLabel = UILabel()

    var writerStackView = UIStackView()
    var writerLabel = UILabel()
    var writerValueLabel = UILabel()

    var actorsStackView = UIStackView()
    var actorsLabel = UILabel()
    var actorsValueLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        directorStackView.translatesAutoresizingMaskIntoConstraints = false
        writerStackView.translatesAutoresizingMaskIntoConstraints = false
        actorsStackView.translatesAutoresizingMaskIntoConstraints = false

        directorStackView.addArrangedSubview(directorLabel)
        directorStackView.addArrangedSubview(directorValueLabel)
        directorStackView.axis = .horizontal

        mainStackView.addArrangedSubview(directorStackView)

        writerStackView.addArrangedSubview(writerLabel)
        writerStackView.addArrangedSubview(writerValueLabel)
        writerStackView.axis = .horizontal

        mainStackView.addArrangedSubview(writerStackView)

        actorsStackView.addArrangedSubview(actorsLabel)
        actorsStackView.addArrangedSubview(actorsValueLabel)
        actorsStackView.axis = .horizontal

        mainStackView.addArrangedSubview(actorsStackView)

        mainStackView.axis = .vertical
        mainStackView.spacing = 10
        mainStackView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        mainStackView.isLayoutMarginsRelativeArrangement = true

        addSubview(mainStackView)

        let allTitleLabels = [writerLabel, directorLabel, actorsLabel]
        allTitleLabels.forEach { (label) in
            apply(textStyle: .subheadline, for: label)
        }

        let allBodyLabel = [writerValueLabel, directorValueLabel, actorsValueLabel]
        allBodyLabel.forEach { (label) in
            apply(textStyle: .body, for: label)
        }

        let constraints = [
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            directorLabel.widthAnchor.constraint(equalTo: writerLabel.widthAnchor),
            actorsLabel.widthAnchor.constraint(equalTo: directorLabel.widthAnchor),
            writerLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2)
        ]
        NSLayoutConstraint.activate(constraints)

        directorLabel.text = NSLocalizedString("Director", comment: "")
        writerLabel.text = NSLocalizedString("Writer", comment: "")
        actorsLabel.text = NSLocalizedString("Actors", comment: "")
        fill(with: MovieDetailsCastInfoModel(director: "", writer: "", actors: ""))
    }

    func apply(textStyle: UIFont.TextStyle, for label: UILabel) {
        label.font = UIFont.preferredFont(forTextStyle: textStyle)
        label.textColor = .black
        label.numberOfLines = 0
    }

    func fill(with model: MovieDetailsCastInfoModel) {
        directorValueLabel.text = model.director
        writerValueLabel.text = model.writer
        actorsValueLabel.text = model.actors
    }
}
