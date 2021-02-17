//
//  MoviesListView.swift
//  Movies
//
//  Created by Piotr Adamczak on 16/02/2021.
//

import Foundation
import UIKit

class MoviesListView: UIView {
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var filtersStackView = UIStackView()
    var filtersLabel = UILabel()
    var filtersButton = UIButton(type: .system)
    var errorView: ErrorView = ErrorView()

    var shouldShowFavouritesOnly: Bool = false {
        didSet {
            let title = shouldShowFavouritesOnly ? NSLocalizedString("Favourites only", comment: "") : NSLocalizedString("All movies", comment: "")
            filtersButton.setTitle(title, for: .normal)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        backgroundColor = .systemBackground

        filtersStackView.translatesAutoresizingMaskIntoConstraints = false
        filtersLabel.translatesAutoresizingMaskIntoConstraints = false
        filtersButton.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        errorView.translatesAutoresizingMaskIntoConstraints = false

        filtersLabel.text = NSLocalizedString("Showing:", comment: "")
        filtersLabel.textAlignment = .right
        filtersButton.contentHorizontalAlignment = .left
        shouldShowFavouritesOnly = false

        filtersStackView.axis = .horizontal
        filtersStackView.alignment = .center
        filtersStackView.distribution = .fillEqually
        filtersStackView.spacing = 10
        filtersStackView.addArrangedSubview(filtersLabel)
        filtersStackView.addArrangedSubview(filtersButton)

        addSubview(collectionView)
        addSubview(errorView)
        addSubview(filtersStackView)

        let constraints = [
            filtersStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            filtersStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            filtersStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            filtersStackView.heightAnchor.constraint(equalToConstant: 44.0),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: filtersStackView.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            errorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            errorView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            errorView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
