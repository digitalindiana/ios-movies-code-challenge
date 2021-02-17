//
//  MovieReviewsView.swift
//  Movies
//
//  Created by Piotr Adamczak on 17/02/2021.
//

import Foundation
import UIKit

class MovieReviewsView: UIView {
    var tableView = UITableView(frame: .zero, style: .grouped)

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        backgroundColor = .systemBackground

        tableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)

        tableView.rowHeight = UITableView.automaticDimension

        let constraints = [
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
