//
//  MovieInteractor.swift
//  MovieVapp
//
//  Created by Haiyan Ma on 01/12/2017.
//  Copyright © 2017 Haiyan Ma. All rights reserved.
//

import Foundation

protocol MovieListInteraction {
    func loadMovies(endPoint: Endpoint, completion: (Result<[Movie]>) -> Void)
    func allMovies() -> [Movie]
}

class MovieListInteractor: MovieListInteraction {

    private var movies: [Movie]?

    func allMovies() -> [Movie] {
        return movies ?? []
    }

    func loadMovies(endPoint: Endpoint, completion: (Result<[Movie]>) -> Void) {
        let movie1 = Movie(name: "Avatar", rating: 4.5)
        let movie2 = Movie(name: "Jurassic World", rating: 4.1)
        let movie3 = Movie(name: "Titanic", rating: 3.9)
        let movies = [movie1, movie2, movie3]
        let result: Result<[Movie]> = Result.success(movies)
        self.movies = movies
        completion(result)
    }
}
