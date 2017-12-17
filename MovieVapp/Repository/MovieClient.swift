//
//  MovieRepository.swift
//  MovieVapp
//
//  Created by Haiyan Ma on 17/12/2017.
//  Copyright © 2017 Haiyan Ma. All rights reserved.
//

import Foundation

class MovieClient {
    
    static var shared = MovieClient()

    private var movies: [Movie] = [Movie(name: "Avatar", rating: 4.5),
                                   Movie(name: "Jurassic World", rating: 4.1, isFavorite: true),
                                   Movie(name: "Titanic", rating: 3.9)]
    
    func getMovieList(from endPoint: Endpoint, completion: (_ result: Result<[Movie]>) -> Void) {
        let result = Result.success(movies)
        completion(result)
    }
    
    func getMovies() -> [Movie] {
        return movies
    }
    
    func toggleFavoriteForMovie(at index: Int) {
        var movies = getMovies()
        guard movies.count >= index + 1 else {
            return
        }
        movies[index].isFavorite = !movies[index].isFavorite
        setMovies(movies)
    }
    
    func setMovies(_ movies: [Movie]) {
        self.movies = movies
    }
}
