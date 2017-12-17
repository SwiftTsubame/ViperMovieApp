//
//  MovieRepository.swift
//  MovieVapp
//
//  Created by Haiyan Ma on 17/12/2017.
//  Copyright © 2017 Haiyan Ma. All rights reserved.
//

import Foundation

class MovieRepository {
    
    static let shared = MovieRepository()
    
    var movies: [Movie] = [Movie(name: "Avatar", rating: 4.5),
                           Movie(name: "Jurassic World", rating: 4.1, isFavorite: true),
                           Movie(name: "Titanic", rating: 3.9)]
    
    func toggleFavoriteForMovie(at index: Int) {
        guard movies.count >= index + 1 else {
            return
        }
        movies[index].isFavorite = !movies[index].isFavorite
    }
}
