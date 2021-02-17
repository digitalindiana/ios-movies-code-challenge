//
//  MovieReviewCell.swift
//  Movies
//
//  Created by Piotr Adamczak on 17/02/2021.
//

import Foundation
import UIKit

class MovieReviewCell: UITableViewCell {
    static var reuseIdentifier: String {
        return "MovieReviewCellIdentifier"
    }

    var stackView = UIStackView()
    var titleLabel = UILabel()
    var reviewLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        reviewLabel.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        
        reviewLabel.numberOfLines = 0
        reviewLabel.font = UIFont.preferredFont(forTextStyle: .caption2)

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(reviewLabel)

        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        stackView.isLayoutMarginsRelativeArrangement = true

        contentView.addSubview(stackView)
        contentView.backgroundColor = UIColor(named: MovieCellColors.cellBackground.rawValue)

        let constraints = [
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
