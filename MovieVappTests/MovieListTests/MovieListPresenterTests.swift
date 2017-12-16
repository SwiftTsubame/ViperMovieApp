//
//  MovieListPresenterTests.swift
//  MovieVappTests
//
//  Created by Haiyan Ma on 02/12/2017.
//  Copyright © 2017 Haiyan Ma. All rights reserved.
//

import XCTest
@testable import MovieVapp

class MovieListPresenterTests: XCTestCase {

    class MockMovieListInteractor: MovieListInteractor {
        var result: Result<[Movie]>?
        override func loadMovies(endPoint: Endpoint, completion: (Result<[Movie]>) -> Void) {
            completion(result!)
        }
    }

    class MockRouter: MovieListRouter {
        var movie: Movie?
        override func presentMovieDetailView(with movie: Movie, fromVC: UIViewController) {
            self.movie = movie
        }
    }

    var presenter2: MovieListPresenter!
    let mockInteractor = MockMovieListInteractor()
    let mockRouter = MockRouter()

    var failureCount: Int = 0
    var successCount: Int = 0

    override func setUp() {
        super.setUp()
        presenter2 = MovieListPresenter(interactor: mockInteractor, router: mockRouter)
    }

    override func tearDown() {
        failureCount = 0
        successCount = 0
        super.tearDown()
    }

    func test_OnSelection_RouterReceivesCorrectMovie() {
        let movie = Movie(name: "aaa", rating: 3)
        presenter2.selectMovie(movie, currentVC: UIViewController())
        XCTAssertEqual("aaa", mockRouter.movie?.name)
    }

    func onFailure() {
        failureCount += 1
    }

    func onSuccess() {
        successCount += 1
    }

    func test_CallOnSuccessActionsWhenSuccess() {
        let movie = Movie(name: "ccc", rating: 1.3)
        let stubMovieResult = Result.success([movie])
        mockInteractor.result = stubMovieResult
        presenter2.loadMovies(onSuccess: onSuccess, onFailure: onFailure)
        XCTAssertEqual(successCount, 1)
        XCTAssertEqual(failureCount, 0)
    }

    func test_CallOnFailureActionsWhenFails() {
        let stubFailedResult: Result<[Movie]> = Result.failure(.noInternet)
        mockInteractor.result = stubFailedResult
        presenter2.loadMovies(onSuccess: onSuccess, onFailure: onFailure)
        XCTAssertEqual(successCount, 0)
        XCTAssertEqual(failureCount, 1)
    }
}
