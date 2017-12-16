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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        title = "Movies"
        loadMovieList()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.updateViewWithDetailVCData { [weak self] (newColor) in
            self?.collectionView?.backgroundColor = newColor
        }
    }

    private func setupCollectionView() {
        collectionView?.backgroundColor = .white
        collectionView?.alwaysBounceVertical = true
        collectionView?.showsVerticalScrollIndicator = true
        collectionView?.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.nameString)
    }

    private func loadMovieList() {
        presenter?.loadMovies(onSuccess: { [weak self] in
            self?.collectionView?.reloadData()
            }, onFailure: {
                print("failure, handle failure in UI")
        })
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
            presenter?.selectMovie(movie, currentVC: self)
        }
    }

    // Delegate Flowlayout
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
}
