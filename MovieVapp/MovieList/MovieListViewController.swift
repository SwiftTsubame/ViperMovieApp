//
//  MovieListView.swift
//  MovieVapp
//
//  Created by Haiyan Ma on 01/12/2017.
//  Copyright © 2017 Haiyan Ma. All rights reserved.
//

import UIKit

class MovieListCollectionViewController: UICollectionViewController {

    var presenter: MovieListPresentation?

    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupSortingNavigationButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Movies"
        presenter?.loadMovies()
    }

    // MARK:- Actions
    @objc private func handleSortingTapped() {
        presenter?.showSortingOptions()
    }

    // MARK:- View Setups
    private func setupCollectionView() {
        collectionView?.backgroundColor = .white
        collectionView?.alwaysBounceVertical = true
        collectionView?.showsVerticalScrollIndicator = true
        collectionView?.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.nameString)
    }

    private func setupSortingNavigationButton() {
        let sortButton = UIBarButtonItem(title: "Sort", style: .done, target: self, action: #selector(handleSortingTapped))
        navigationItem.rightBarButtonItem = sortButton
    }
}

extension MovieListCollectionViewController: MovieListViewInterface {

    func refreshMovieList() {
        self.collectionView?.reloadData()
    }
    
    func showLoadingError(errorMessage: String) {
        print("show error messagae: \(errorMessage)")
    }
}

extension MovieListCollectionViewController: CellInterfaceDelegate {
    func toggleFavoriteMovie(at index: Int) {
        presenter?.toggleFavorite(movie: index)
    }
}

// MARK:- CollectionView Delegates
extension MovieListCollectionViewController: UICollectionViewDelegateFlowLayout {
    // Datasource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter?.sections ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.movieCount ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.nameString,
                                 for: indexPath) as? MovieCell else { fatalError() }
        let movie = presenter?.movie(at: indexPath.item)
        cell.configCell(movie)
        cell.tag = indexPath.item
        cell.cellInterfaceDelegate = self
        return cell
    }

    // Delegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movie = presenter?.movie(at: indexPath.item) {
            presenter?.selectMovie(movie)
        }
    }

    // Delegate Flowlayout
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2.2
        let height = width * 1.48
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
}
