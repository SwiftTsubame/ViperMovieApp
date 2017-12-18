//
//  MovieListView.swift
//  MovieVapp
//
//  Created by Haiyan Ma on 01/12/2017.
//  Copyright © 2017 Haiyan Ma. All rights reserved.
//

import UIKit

protocol MovieListViewInterface: class {
    func loadMovieListWithMovies()
    func showLoadingError(errorMessage: String)
}

class MovieListCollectionViewController: UICollectionViewController {

    var presenter: MovieListPresentation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movies"
        setupCollectionView()
        setupSortingNavigationButton()
        presenter?.loadMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.loadMovies()
    }

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

    @objc private func handleSortingTapped() {
        print("Sort Tapped")
    }
}

extension MovieListCollectionViewController: MovieListViewInterface {

    func loadMovieListWithMovies() {
        self.collectionView?.reloadData()
    }
    
    func showLoadingError(errorMessage: String) {
        print("show error messagae: \(errorMessage)")
    }
}

// MARK: CollectionView Delegates
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
                                 for: indexPath) as? MovieCell else {
            fatalError()
        }
        let movie = presenter?.movie(at: indexPath.item)
        cell.configCell(movie)
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
        return CGSize(width: collectionView.frame.width, height: 50)
    }
}
