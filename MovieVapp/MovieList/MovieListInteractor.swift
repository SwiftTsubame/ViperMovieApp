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
    func showLoadingMovieListError(_ error: MovieErrorType)
}

class MovieListInteractor: MovieListInteraction {

    weak var output: MovieListInteractionOutput?
    
    private(set) var movies: [Movie]?
    private let client: MovieClient
    
    init(client: MovieClient = MovieClient.shared) {
        self.client = client
    }
    
    func loadMovies(endPoint: Endpoint) {
        client.getMovieList(from: endPoint) { (result) in
            switch result {
            case .success(let movies):
                self.movies = movies
                output?.loadMovieList(with: movies)
            case .failure(let errorType):
                output?.showLoadingMovieListError(errorType)
            }
        }
    }
}
