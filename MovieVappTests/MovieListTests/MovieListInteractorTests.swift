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

    class FakeInteractionOutput: MovieListInteractionOutput {
        var movies: [Movie]?
        
        var error: MovieErrorType?
        
        func loadMovieList(with movies: [Movie]) {
            self.movies = movies
        }
        
        func showLoadingMovieListError(_ error: MovieErrorType) {
            self.error = error
        }
    }
    
    class FakeClient: MovieClient {
        var fakeResult: Result<[Movie]>?
        
        override func getMovieList(from endPoint: Endpoint, completion: (Result<[Movie]>) -> Void) {
            guard let result = fakeResult else {
                XCTFail("Didnot supply fake result in Fake MovieList Client")
                return
            }
            completion(result)
        }
    }
    
    struct MockMovieListResult {
        static let errorResult: Result<[Movie]> = Result.failure(MovieErrorType.noInternet)
        static let successfulResult: Result<[Movie]> = Result.success([Movie(name: "abc", rating: 1.3),
                                                                       Movie(name: "efg", rating: 2.5)])
    }
    
    var subject: MovieListInteractor!
    let fakeClient = FakeClient()
    let fakeOutput = FakeInteractionOutput()
    override func setUp() {
        super.setUp()
        subject = MovieListInteractor(client: fakeClient)
        subject.output = fakeOutput
    }
    
    func testLoadMovieReturnsMoviesUponSuccess() {
        fakeClient.fakeResult = MockMovieListResult.successfulResult
        subject.loadMovies(endPoint: .movieList)
        guard let movies = subject.movies else {
            XCTFail("Nil Movie List Returned")
            return
        }
        XCTAssertEqual(movies.count, 2)
        XCTAssertEqual(movies.map{ $0.name }, ["abc", "efg"])
        XCTAssertEqual(movies.map{ $0.rating }, [1.3, 2.5])
    }
    
    func testLoadMovieSuccessCaughtInOutput() {
        fakeClient.fakeResult = MockMovieListResult.successfulResult
        subject.loadMovies(endPoint: .movieList)
        let successfulResult = MockMovieListResult.successfulResult
        guard let outPutMovies = fakeOutput.movies else {
            XCTFail("Output has caught no movies")
            return
        }
        switch successfulResult {
        case .success(let movies):
            XCTAssertEqual(movies.count, fakeOutput.movies?.count)
            XCTAssertEqual(movies.map{ $0.name }, outPutMovies.map{ $0.name })
            XCTAssertEqual(movies.map{ $0.rating },
                         outPutMovies.map{ $0.rating })
        default:
            XCTFail("should be case success instead failure")
        }
    }
    
    func testLoadMovieFailureCaughtInOutput() {
        fakeClient.fakeResult = MockMovieListResult.errorResult
        subject.loadMovies(endPoint: .movieList)
        let errorResult = MockMovieListResult.errorResult
        switch errorResult {
        case .failure(let errorType):
            XCTAssertEqual(fakeOutput.error, errorType)
        default:
            XCTFail("should be case failure instead success")
        }
    }
}
