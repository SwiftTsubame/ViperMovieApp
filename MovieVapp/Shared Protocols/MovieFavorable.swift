//
//  MovieFavorable.swift
//  MovieVapp
//
//  Created by Haiyan Ma on 18/12/2017.
//  Copyright © 2017 Haiyan Ma. All rights reserved.
//

import Foundation

protocol MovieFavoritable {
    var movies: [Movie]? { get set }
    var movie: Movie? { get set }
    mutating func toggleFavorite(movie: Movie)
}

extension MovieFavoritable {
    mutating func toggleFavorite(movie: Movie) {
        var newMovie = movie
        newMovie.isFavorite = !newMovie.isFavorite
        self.movie = newMovie
        updateMovieRepository(with: newMovie)
    }

    mutating func updateMovieRepository(with newMovie: Movie) {
        let moviesNames = MovieClient.shared.getMovies().map { $0.name }
        guard let index = moviesNames.index(of: newMovie.name) else { return }
        var movies = MovieClient.shared.getMovies()
        movies[index] = newMovie
        self.movies = movies
        MovieClient.shared.setMovies(movies)
    }
}
