//
//  MovieListRouter.swift
//  MovieVapp
//
//  Created by Haiyan Ma on 01/12/2017.
//  Copyright © 2017 Haiyan Ma. All rights reserved.
//

import UIKit

protocol MovieListRouting: class {
    var container: MovieDetailDependencyContainer { get set }
    func presentMovieDetailView(with movie: Movie, fromVC: UIViewController)
}

class MovieListRouter: MovieListRouting {
    var container = MovieDetailDependencyContainer()

    func presentMovieDetailView(with movie: Movie, fromVC: UIViewController) {
        let detailVC = container.createModule(for: movie)
        fromVC.navigationController?.pushViewController(detailVC, animated: true)
    }
}
