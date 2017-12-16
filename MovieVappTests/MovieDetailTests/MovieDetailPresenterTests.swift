//
//  MovieDetailPresenterTests.swift
//  MovieVappTests
//
//  Created by Haiyan Ma on 04/12/2017.
//  Copyright © 2017 Haiyan Ma. All rights reserved.
//

import XCTest
@testable import MovieVapp

class MovieDetailPresenterTests: XCTestCase {

    var movieDetailPresenter: MovieDetailPresenter!

    class MockMovieDetailInteractor: MovieDetailInteraction {
        var movie: Movie?
    }

    class MockRouter: MovieDetailRouting { }

    let mockInteractor = MockMovieDetailInteractor()
    let mockRouter = MockRouter()

    override func setUp() {
        super.setUp()
        movieDetailPresenter = MovieDetailPresenter(interactor: mockInteractor, router: mockRouter)
    }

    func testShowMovieDetailHandleFailureWhenNoMovie() {
        mockInteractor.movie = nil

        movieDetailPresenter.showDetailOnViewDidLoad(withMovie: { (_) in
            XCTAssertTrue(false, "test should fail because we have no movie")
        }, noMovie: {
            XCTAssertTrue(true, "failed as we want")
        })
    }

    func testShowMovieDetailSucceedsWithMovie() {
        mockInteractor.movie = Movie(name: "There is movie!", rating: 23)
        movieDetailPresenter.showDetailOnViewDidLoad(withMovie: { (passedMovie) in
            XCTAssertEqual(mockInteractor.movie?.name, passedMovie.name)
        }, noMovie: {
            XCTAssertTrue(false, "test should NOT fail because there is movie")
        })
    }

}
