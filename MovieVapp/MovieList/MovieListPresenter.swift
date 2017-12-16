//  MovieListPresenter.swift
//  MovieVapp
//
//  Created by Haiyan Ma on 01/12/2017.
//  Copyright © 2017 Haiyan Ma. All rights reserved.
//

import Foundation
import UIKit

protocol MovieListPresentation: class {
    var sections: Int { get }
    var movieCount: Int { get }
    func movie(at index: Int) -> Movie?
    func loadMovies(onSuccess: () -> Void, onFailure: () -> Void)
    func selectMovie(_ movie: Movie, currentVC: UIViewController)
}

class MovieListPresenter: MovieListPresentation {

    // MARK: Init
    private let interactor: MovieListInteraction
    private let router: MovieListRouting
    
    private var color: UIColor?

    init(interactor: MovieListInteraction, router: MovieListRouting) {
        self.interactor = interactor
        self.router = router
    }

    // MARK: Logic
    var sections: Int {
        return 1
    }

    var movieCount: Int {
        return interactor.allMovies().count
    }

    func movie(at index: Int) -> Movie? {
        if index > interactor.allMovies().count - 1 {
            return nil
        }
        return interactor.allMovies()[index]
    }

    func loadMovies(onSuccess: () -> Void, onFailure: () -> Void) {
        interactor.loadMovies(endPoint: .movieList) { (result) in
            switch result {
            case .success:
                onSuccess()
            case .failure:
                onFailure()
            }
        }
    }

    func selectMovie(_ movie: Movie, currentVC: UIViewController) {
        router.presentMovieDetailView(with: movie, fromVC: currentVC)
    }
}
