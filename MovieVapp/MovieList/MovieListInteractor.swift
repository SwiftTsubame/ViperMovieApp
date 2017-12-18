//
//  MovieInteractor.swift
//  MovieVapp
//
//  Created by Haiyan Ma on 01/12/2017.
//  Copyright © 2017 Haiyan Ma. All rights reserved.
//

import Foundation

protocol MovieListInteraction: MovieFavoritable {
    func loadMovies(endPoint: Endpoint)
    func sortMovies(sortType: SortType)
}

protocol MovieListInteractionOutput: class {
    var movies: [Movie]? { get }
    func refreshMovieList(with movies: [Movie])
    func showLoadingMovieListError(_ error: MovieErrorType)
}

class MovieListInteractor: MovieListInteraction {
    
    internal var movie: Movie?

    weak var output: MovieListInteractionOutput?
    
    var movies: [Movie]?
    private let client: MovieClient
    
    init(client: MovieClient = MovieClient.shared) {
        self.client = client
    }
    
    func loadMovies(endPoint: Endpoint) {
        client.getMovieList(from: endPoint) { (result) in
            switch result {
            case .success(let movies):
                self.movies = movies
                output?.refreshMovieList(with: movies)
            case .failure(let errorType):
                output?.showLoadingMovieListError(errorType)
            }
        }
    }

    func sortMovies(sortType: SortType) {
        switch sortType {
        case .name:
            self.movies = self.movies?.sorted(by: {
                $0.name < $1.name
            })
        case .rating:
            self.movies = self.movies?.sorted(by: {
                $0.rating < $1.rating
            })
        default: break
        }
        client.setMovies(self.movies ?? [])
        output?.refreshMovieList(with: self.movies ?? [])
    }
}
