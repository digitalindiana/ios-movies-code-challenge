//
//  MoviesListViewController.swift
//  Movies
//
//  Created by Piotr Adamczak on 13/01/2021.
//

import UIKit


class MoviesListViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var errorView: ErrorView!

    let searchController = UISearchController(searchResultsController: nil)
    var viewModel: MoviesListViewModelProtocol? = DefaultMoviesListViewModel()

    // Constants
    static let numberOfCellsPerRow: CGFloat = 2

    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("Movies list", comment: "Title of Movies List Controller")

        configureCollectionView()
        configureSearchController()
        configureHandlers()

        viewModel?.setupDataSource(for: collectionView)
        viewModel?.clearData(generateError: true)
    }

    func configureCollectionView() {
        collectionView.delegate = self

        // Calculate item size and section inset
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
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
        errorView.isHidden = true
        viewModel?.errorHandler = { errorData in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.errorView.isHidden = false
                self.collectionView.isHidden = true
                self.errorView.show(errorData)
            }
        }

        viewModel?.moviesLoaded = { [weak self] _ in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.errorView.isHidden = true
                self.collectionView.isHidden = false
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let movie = sender as? MovieMetadata,
           let movieDetailsVC = segue.destination as? MovieDetailsViewController,
           segue is MovieDetailsSegue {
            movieDetailsVC.imdbId = movie.imdbID
        }
    }
}

extension MoviesListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchedText = searchController.searchBar.text,
              searchedText.count > 2 else {
            viewModel?.clearData(generateError: true)
            return
        }

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
        performSegue(withIdentifier: MovieDetailsSegue.identifier, sender: selectedMovie)
    }
}
