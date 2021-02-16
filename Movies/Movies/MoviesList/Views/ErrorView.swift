//
//  ErrorView.swift
//  Movies
//
//  Created by Piotr Adamczak on 14/01/2021.
//

import Foundation
import UIKit

// sourcery: AutoMockable
protocol ErrorData {
    var imageName: String { get }
    var errorDescription: String { get }
}

class ErrorView: UIView {
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var errorLabel: UILabel!

    func show(_ errorData: ErrorData) {
        imageView.image = UIImage(named: errorData.imageName)
        errorLabel.text = errorData.errorDescription
    }
}
