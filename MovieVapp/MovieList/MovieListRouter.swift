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
    var alertController: AlertController { get set }
    func presentMovieDetailView(with movie: Movie)
    func presentSortOptions(sortCompletion: ((SortType) -> ())?)
}

class MovieListRouter: Router, MovieListRouting {
    
    var container = MovieDetailDependencyContainer()
    
    let listContainer = ListDependencyContainer()
    var alertController = AlertController.shared

    func presentMovieDetailView(with movie: Movie) {
        let detailVC = container.createModule(for: movie)
        guard let listViewVC = topNavController else { return }
        listViewVC.pushViewController(detailVC, animated: true)
    }

    func presentSortOptions(sortCompletion: ((SortType) -> ())?) {
        guard let listViewVC = topViewController else { return }
        AlertController.shared.presentSortOptions(on: listViewVC, sortCompletion: sortCompletion)
    }
}
