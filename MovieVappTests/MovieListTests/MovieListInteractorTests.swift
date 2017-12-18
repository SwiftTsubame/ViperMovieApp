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
                             Movie(name: "efg", rating: 3.5, imageName: "avatar"),
                             Movie(name: "bbb", rating: 2.5, imageName: "avatar")]

    }
    
    var subject: MovieListInteractor!
    let movieClient = FakeClient()
    let movieListInteractorOutput = FakeInteractionOutput()

    override func setUp() {
        super.setUp()
        subject = MovieListInteractor(client: movieClient)
        subject.output = movieListInteractorOutput
    }

    func test_LoadMovieWithSuccess_ReturnsMoviesInSubject() {
        loadMovieListWithSuccess()
        // Returned movies are caught correctly in the subject under test
        guard let movies = subject.movies else {
            XCTFail("Nil Movie List Returned")
            return
        }
        XCTAssertEqual(movies, StubMovieListResult.movies)
    }
    
    func test_LoadMovieWithSuccess_MoviesAreCaughtInSubjectOutputProtocol() {
        loadMovieListWithSuccess()
        // Catch Movies in Output Protocol
        guard let moviesCaughtInInteractionOutputProtocol = movieListInteractorOutput.movies else {
            XCTFail("Output has caught no movies")
            return
        }
        switch StubMovieListResult.successfulResult {
        case .success(let movies):
            XCTAssertEqual(movies, moviesCaughtInInteractionOutputProtocol)
        default:
            XCTFail("should be case success instead failure")
        }
    }
    
    func test_LoadMovieWithError_ErrorCaughtInOutput() {
        loadMovieListInSubjectWithError()
        // Catch Error in Output Protocol
        switch StubMovieListResult.errorResult {
        case .failure(let errorType):
            XCTAssertEqual(movieListInteractorOutput.error, errorType)
        default:
            XCTFail("should be case failure instead success")
        }
    }

    func test_MoviesSortedByName_UponSortName() {
        loadMovieListWithSuccess()
        subject.sortMovies(sortType: .name)
        // orginal movie names are: ["abc", "efg", "bbb"]
       let movieBBB = StubMovieListResult.movies[2] // get movie bbb
        XCTAssertEqual(movieBBB, movieListInteractorOutput.movies?[1])
    }

    func test_MoviesByRating_UponSortRating() {
        loadMovieListWithSuccess()
        subject.sortMovies(sortType: .rating)
        // orginal movie ratings are: [1.3, 3.5, 2.5]
        let movieHighestRating = StubMovieListResult.movies[1] // get movie bbb
        XCTAssertEqual(movieHighestRating, movieListInteractorOutput.movies?[2])
    }

    // Helpers
    private func loadMovieListWithSuccess() {
        movieClient.result = StubMovieListResult.successfulResult
        subject.loadMovies(endPoint: .movieList)
    }

    private func loadMovieListInSubjectWithError() {
        let feedErrorResult = StubMovieListResult.errorResult
        movieClient.result = feedErrorResult
        subject.loadMovies(endPoint: .movieList)
    }
}
