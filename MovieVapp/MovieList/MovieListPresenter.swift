//  MovieListPresenter.swift
//  MovieVapp
//
//  Created by Haiyan Ma on 01/12/2017.
//  Copyright © 2017 Haiyan Ma. All rights reserved.
//

import Foundation

// MARK:- Movie List Presentation Protocol
protocol MovieListPresentation: class {
    var sections: Int { get }
    var movieCount: Int { get }
    func movie(at index: Int) -> Movie?
    func loadMovies()
    func selectMovie(_ movie: Movie)
    func showSortingOptions()
    func toggleFavorite(movie atIndex: Int)
}

// MARK:- Presenter -> View Interface
protocol MovieListViewInterface: class {
    func refreshMovieList()
    func showLoadingError(errorMessage: String)
}

// MARK:- Presenter
class MovieListPresenter: MovieListPresentation {

    // MARK: Init
    private var interactor: MovieListInteraction
    private let router: MovieListRouting
    private let movieClient: MovieClient

    init(interactor: MovieListInteraction, router: MovieListRouting, movieClient: MovieClient = MovieClient.shared) {
        self.interactor = interactor
        self.router = router
        self.movieClient = movieClient
    }
    
    weak var movieListViewInterface: MovieListViewInterface?
    
    private(set) var movies: [Movie]? {
        didSet {
            guard let movies = movies, !movies.isEmpty else {
                movieListViewInterface?.showLoadingError(errorMessage: "No movie Loaded")
                return
            }
            movieListViewInterface?.refreshMovieList()
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
        router.presentSortOptions { [weak self] (sortType) in
            self?.interactor.sortMovies(sortType: sortType)
        }
    }

    func toggleFavorite(movie atIndex: Int) {
        guard let movie = movies?[atIndex] else { return }
        interactor.toggleFavorite(movie: movie)
        self.movies = movieClient.getMovies()
    }
}

extension MovieListPresenter: MovieListInteractionOutput {

    func refreshMovieList(with movies: [Movie]) {
        self.movies = movies
    }
    
    func showLoadingMovieListError(_ error: MovieErrorType) {
        movieListViewInterface?.showLoadingError(errorMessage: "Some Error occured")
    }
}
