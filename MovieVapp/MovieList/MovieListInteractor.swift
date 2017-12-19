//
//  MovieInteractor.swift
//  MovieVapp
//
//  Created by Haiyan Ma on 01/12/2017.
//  Copyright © 2017 Haiyan Ma. All rights reserved.
//

import Foundation

// MARK:- Interaction Protocol
protocol MovieListInteraction: MovieFavoritable {
    func loadMovies(endPoint: Endpoint)
    func sortMovies(sortType: SortType)
}

// MARK:- Interaction -> Presenter Protocol
protocol MovieListInteractionOutput: class {
    var movies: [Movie]? { get }
    func refreshMovieList(with movies: [Movie])
    func showLoadingMovieListError(_ error: MovieErrorType)
}

// MARK:- Interactor
class MovieListInteractor: MovieListInteraction {
    
    internal var movie: Movie? // to manage the movie whose favorite is being toggled
    var movies: [Movie]?
    weak var output: MovieListInteractionOutput?

    /// Init
    private let client: MovieClient

    init(client: MovieClient = MovieClient.shared) {
        self.client = client
    }

    /// Get movies from webservice (currently fake data in memory).
    /// On success: refresh movie list in collectionview
    /// On failure: show error view in collectionview
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

    /// Sort movies against movie name or movie rating.
    /// On finish, update movies in Movie Client
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
    }
}
