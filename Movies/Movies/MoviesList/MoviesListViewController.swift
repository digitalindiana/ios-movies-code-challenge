//
//  MoviesListViewController.swift
//  Movies
//
//  Created by Piotr Adamczak on 16/02/2021.
//

import UIKit

class MoviesListViewController: UIViewController {

    let searchController = UISearchController(searchResultsController: nil)
    var viewModel: MoviesListViewModelProtocol? = DefaultMoviesListViewModel()

    var favouriteButton: UIBarButtonItem?
    var unfavouriteButton: UIBarButtonItem?

    var aView: MoviesListView {
        return view as! MoviesListView
    }

    // Constants
    static let numberOfCellsPerRow: CGFloat = 2

    override func loadView() {
        view = MoviesListView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("Movies list", comment: "Title of Movies List Controller")

        aView.collectionView.delegate = self
        aView.collectionView.register(MovieListCell.self, forCellWithReuseIdentifier: MovieListCell.reuseIdentifier)
        aView.filtersButton.addTarget(self, action: #selector(MoviesListViewController.favouritesFilterTapped), for: .touchUpInside)

        configureSearchController()
        configureHandlers()

        viewModel?.setupDataSource(for: aView.collectionView)
        viewModel?.clearData(generateError: true)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureCollectionView()
    }

    func configureCollectionView() {
        // Calculate item size and section inset
        if let flowLayout = aView.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let horizontalSpacing = flowLayout.minimumInteritemSpacing
            flowLayout.sectionInset = UIEdgeInsets(top: horizontalSpacing, left: horizontalSpacing,
                                                   bottom: horizontalSpacing, right: horizontalSpacing)
            let separatorsWidth = max(0, MoviesListViewController.numberOfCellsPerRow - 1) * horizontalSpacing + 2 * horizontalSpacing
            let cellWidth = (view.frame.width - separatorsWidth) / MoviesListViewController.numberOfCellsPerRow
            flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        }
    }

    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.placeholder = NSLocalizedString("Search for movie..", comment: "")
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController!.navigationBar.sizeToFit()
        definesPresentationContext = true
    }

    func configureHandlers() {
        aView.errorView.isHidden = true
        viewModel?.errorHandler = { errorData in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.aView.hideActivityView()
                self.aView.errorView.isHidden = false
                self.aView.collectionView.isHidden = true
                self.aView.errorView.show(errorData)
            }
        }

        viewModel?.moviesLoaded = { [weak self] _ in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.aView.hideActivityView()
                self.aView.errorView.isHidden = true
                self.aView.collectionView.isHidden = false
            }
        }
    }

    @objc func favouritesFilterTapped() {
        guard var viewModel = viewModel else { return }
        viewModel.showOnlyFavourites = !viewModel.showOnlyFavourites
        aView.shouldShowFavouritesOnly =  viewModel.showOnlyFavourites
    }
}

extension MoviesListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchedText = searchController.searchBar.text,
              searchedText.count > 2 else {
            viewModel?.clearData(generateError: true)
            return
        }

        aView.showActivityView()
        viewModel?.fetchMovies(searchedTitle: searchedText, forced: true)
    }
}

extension MoviesListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.dismiss(animated: true)
    }
}

extension MoviesListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == collectionView.numberOfItems(inSection: indexPath.section) - 1 {
            viewModel?.fetchMoreMovies()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedMovie = viewModel?.dataSource?.itemIdentifier(for: indexPath) else { return }

        let movieDetailsVC = MovieDetailsViewController()
        movieDetailsVC.movieMetadata = selectedMovie
        navigationController?.pushViewController(movieDetailsVC, animated: true)
    }
}
