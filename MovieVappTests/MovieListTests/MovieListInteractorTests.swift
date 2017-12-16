//
//  MovieListInteractorTests.swift
//  MovieVappTests
//
//  Created by Haiyan Ma on 02/12/2017.
//  Copyright © 2017 Haiyan Ma. All rights reserved.
//

import XCTest
@testable import MovieVapp

class MovieListInteractorTests: XCTestCase {

    class MockMovieListInteractor: MovieListInteraction {

        func getMovies() -> [Movie] {
            return []
        }

        var result: Result<[Movie]>?

        func loadMovies(endPoint: Endpoint, completion: (Result<[Movie]>) -> Void) {
            completion(result!)
        }
    }

    var mockMovieListInteractor: MockMovieListInteractor?

    override func setUp() {
        super.setUp()
        mockMovieListInteractor = MockMovieListInteractor()
    }

    func test_NonEmptyMovieListLoaded() {
        let movie = Movie(name: "abc", rating: 1.3)
        let stubMovieResult = Result.success([movie])
        mockMovieListInteractor?.result = stubMovieResult
        mockMovieListInteractor?.loadMovies(endPoint: .movieList, completion: { (result) in
            switch result {
            case .success(let movies):
                XCTAssertEqual(1, movies.count)
            case .failure:
                XCTFail("This test should have succeeded")
            }
        })
    }
}
