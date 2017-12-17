//
//  MovieInteractor.swift
//  MovieVapp
//
//  Created by Haiyan Ma on 01/12/2017.
//  Copyright © 2017 Haiyan Ma. All rights reserved.
//

import Foundation

protocol MovieListInteraction {
    func loadMovies(endPoint: Endpoint)
}

protocol MovieListInteractionOutput: class {
    var movies: [Movie]? { get }
    func loadMovieList(with movies: [Movie])
    func showLoadingMovieListError(_ error: ErrorType)
}

class MovieListInteractor: MovieListInteraction {

    weak var output: MovieListInteractionOutput?
    
    private(set) var movies: [Movie]? {
        didSet {
        }
    }

    func loadMovies(endPoint: Endpoint) {
        switch resultMovies() {
        case .success(let movies):
            output?.loadMovieList(with: movies)
        case .failure(let errorType):
            output?.showLoadingMovieListError(errorType)
        }
    }
    
    private func resultMovies() -> Result<[Movie]> {
        self.movies = MovieRepository.shared.movies
        let result = Result.success(MovieRepository.shared.movies)
        return result
    }
}
