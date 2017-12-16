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

    override func setUp() {
        super.setUp()
    }

    func testInteractorReceivesMovieFromRouter() {
        let movie = Movie(name: "lalala", rating: 2)
        let container = MovieDetailDependencyContainer()
        let viewController = container.createModule(for: movie) as? MovieDetailViewController
        let interactor = viewController?.presenter?.interactor
        XCTAssertEqual(interactor?.movie?.name, movie.name)
    }
}
