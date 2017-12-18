//  MovieListPresenter.swift
//  MovieVapp
//
//  Created by Haiyan Ma on 01/12/2017.
//  Copyright © 2017 Haiyan Ma. All rights reserved.
//

import Foundation

protocol MovieListPresentation: class {
    var sections: Int { get }
    var movieCount: Int { get }
    func movie(at index: Int) -> Movie?
    func loadMovies()
    func selectMovie(_ movie: Movie)
    func showSortingOptions()
}

class MovieListPresenter: MovieListPresentation {

    // MARK: Init
    private let interactor: MovieListInteraction
    private let router: MovieListRouting

    init(interactor: MovieListInteraction, router: MovieListRouting) {
        self.interactor = interactor
        self.router = router
    }
    
    weak var movieListViewInterface: MovieListViewInterface?
    
    private(set) var movies: [Movie]? {
        didSet {
            guard let movies = movies, !movies.isEmpty else {
                movieListViewInterface?.showLoadingError(errorMessage: "No movie Loaded")
                return
            }
            movieListViewInterface?.loadMovieListWithMovies()
        }
    }

    // MARK: Logic
    var sections: Int {
        return 1
    }

    var movieCount: Int {
        return movies?.count ?? 0
    }

    func movie(at index: Int) -> Movie? {
        return movies?[index] ?? nil
    }

    func loadMovies() {
        interactor.loadMovies(endPoint: .movieList)
    }

    func selectMovie(_ movie: Movie) {
        router.presentMovieDetailView(with: movie)
    }

    func showSortingOptions() {
        print("show sorting options")
        router.presentSortOptions { [weak self] (sortType) in
            self?.interactor.sortMovies(sortType: sortType)
        }
    }
}

extension MovieListPresenter: MovieListInteractionOutput {
    func loadMovieList(with movies: [Movie]) {
        self.movies = movies
    }
    
    func showLoadingMovieListError(_ error: MovieErrorType) {
        movieListViewInterface?.showLoadingError(errorMessage: "Some Error occured")
    }
}
