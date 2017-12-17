//
//  MovieDetailInteractorTests.swift
//  MovieVappTests
//
//  Created by Haiyan Ma on 04/12/2017.
//  Copyright © 2017 Haiyan Ma. All rights reserved.
//

import XCTest
@testable import MovieVapp

class MovieDetailInteractorTests: XCTestCase {

    var subject: MovieDetailInteractor!
    let fakeMovie = Movie(name: "Avatar", rating: 4.5)
    
    override func setUp() {
        super.setUp()
        let container = MovieDetailDependencyContainer()
        let viewController = container.createModule(for: fakeMovie) as? MovieDetailViewController
        guard let interactor = viewController?.presenter?.interactor else {
            XCTFail("interactor non existing")
            return
        }
        subject = interactor as! MovieDetailInteractor
    }

    func testInteractorReceivesMovieFromRouter() {
        XCTAssertEqual(subject?.movie?.name, fakeMovie.name)
    }
    
    func testToggleMovieWillChangeFavoriteFlag() {
        guard let oldFavoriteValue = subject.movie?.isFavorite else {
            XCTFail("Movie has no isFavorite field")
            return
        }
        subject.toggleFavorite()
        guard let newFavoriteValue = subject.movie?.isFavorite else {
            XCTFail("New Movie has no isFavorite field")
            return
        }
        XCTAssertEqual(oldFavoriteValue, !newFavoriteValue)
    }
    
    func testToggleMovieWillUpdateRepository() {
        MovieClient.shared.setMovies([fakeMovie])
        let oldFavoriteValue = MovieClient.shared.getMovies()[0].isFavorite
        
        subject.toggleFavorite()
        XCTAssertEqual(MovieClient.shared.getMovies()[0].isFavorite, !oldFavoriteValue)
    }
}
