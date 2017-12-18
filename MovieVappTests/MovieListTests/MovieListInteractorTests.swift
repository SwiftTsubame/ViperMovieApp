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
        
        func refreshMovieList(with movies: [Movie]) {
            self.movies = movies
        }
        
        func showLoadingMovieListError(_ error: MovieErrorType) {
            self.error = error
        }
    }
    
    class FakeClient: MovieClient {

        var result: Result<[Movie]>?
        
        override func getMovieList(from endPoint: Endpoint, completion: (Result<[Movie]>) -> Void) {
            guard let result = result else {
                XCTFail("Didnot supply fake result in Fake MovieList Client")
                return
            }
            completion(result)
        }
    }
    
    struct StubMovieListResult {
        static let errorResult: Result<[Movie]> = Result.failure(MovieErrorType.noInternet)
        static let successfulResult: Result<[Movie]> = Result.success(StubMovieListResult.movies)
        static let movies = [Movie(name: "abc", rating: 1.3, imageName: "avatar"),
                             Movie(name: "efg", rating: 2.5, imageName: "avatar"),
                             Movie(name: "bbbfg", rating: 2.5, imageName: "avatar")]

    }
    
    var subject: MovieListInteractor!
    let fakeClient = FakeClient()
    let fakeInteractorOutput = FakeInteractionOutput()

    override func setUp() {
        super.setUp()
        subject = MovieListInteractor(client: fakeClient)
        subject.output = fakeInteractorOutput
    }
    
    func testLoadMovieReturnsMoviesUponSuccess() {
        // Feed correct list of movies in movie client
        fakeClient.result = StubMovieListResult.successfulResult
        // Load movies
        subject.loadMovies(endPoint: .movieList)
        // Returned movies are caught correctly in the subject under test
        guard let movies = subject.movies else {
            XCTFail("Nil Movie List Returned")
            return
        }
        XCTAssertEqual(movies, StubMovieListResult.movies)
    }
    
    func test_LoadMovieSuccessful_MoviesAreCaughtInOutput() {
        // Feed correct list of movies in movie client
        let successfulResult = StubMovieListResult.successfulResult
        fakeClient.result = successfulResult
        // Load movies
        subject.loadMovies(endPoint: .movieList)

        // Catch Movies in Output Protocol
        guard let moviesCaughtInInteractionOutputProtocol = fakeInteractorOutput.movies else {
            XCTFail("Output has caught no movies")
            return
        }
        switch successfulResult {
        case .success(let movies):
            XCTAssertEqual(movies, moviesCaughtInInteractionOutputProtocol)
        default:
            XCTFail("should be case success instead failure")
        }
    }
    
    func test_LoadMovieFailed_ErrorCaughtInOutput() {
        // Feed error Result in loading movies
        let feedErrorResult = StubMovieListResult.errorResult
        fakeClient.result = feedErrorResult
        // Load movies
        subject.loadMovies(endPoint: .movieList)
        // Catch Error in Output Protocol
        switch feedErrorResult {
        case .failure(let errorType):
            XCTAssertEqual(fakeInteractorOutput.error, errorType)
        default:
            XCTFail("should be case failure instead success")
        }
    }
}
