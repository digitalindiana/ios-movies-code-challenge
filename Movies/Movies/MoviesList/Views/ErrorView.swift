//
//  ErrorView.swift
//  Movies
//
//  Created by Piotr Adamczak on 16/02/2021.
//

import Foundation
import UIKit

protocol ErrorData {
    var imageName: String { get }
    var errorDescription: String { get }
}

class ErrorView: UIView {
    var stackView = UIStackView()
    var topSeparatorView = UIView()
    var imageView = UIImageView()
    var errorLabel = UILabel()
    var bottomSeparatorView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        addSubview(stackView)

        imageView.contentMode = .scaleAspectFit

        errorLabel.textAlignment = .center
        errorLabel.numberOfLines = 0

        let subviews = [topSeparatorView, imageView, errorLabel, bottomSeparatorView]
        subviews.forEach { (subview) in
            stackView.addArrangedSubview(subview)
        }

        let constraints = [
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: widthAnchor),
            stackView.heightAnchor.constraint(equalTo: heightAnchor),
            imageView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.4),
            errorLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.9),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    func show(_ errorData: ErrorData) {
        imageView.image = UIImage(named: errorData.imageName)
        errorLabel.text = errorData.errorDescription
    }
}
