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

    class MockInteracotr: MovieListInteractor {
        override func loadMovies(endPoint: Endpoint) {
        }
    }
    
    class MockRouter: MovieListRouting {

        var alertController: AlertController = AlertController()

        func presentSortOptions(sortCompletion: ((SortType) -> ())?) {
        }

        var container: MovieDetailDependencyContainer = MovieDetailDependencyContainer()
        var movie: Movie?
        func presentMovieDetailView(with movie: Movie) {
            self.movie = movie
        }
    }
    
    class MockInterface: MovieListViewInterface {
        var shouldLoadMovieListWithMovies = false
        var shouldShowError = false

        func refreshMovieList() {
            shouldLoadMovieListWithMovies = true
        }
        
        func showLoadingError(errorMessage: String) {
            shouldShowError = true
        }
    }

    var presenter: MovieListPresenter?
    let mockInteractor = MockInteracotr()
    let mockRouter = MockRouter()
    let fakeMovies = [Movie(name: "aaa", rating: 1, imageName: "avatar")]
    var mockInterface: MockInterface?
    
    override func setUp() {
        super.setUp()
        presenter = MovieListPresenter(interactor: mockInteractor, router: mockRouter)
        mockInterface = MockInterface()
        presenter?.movieListViewInterface = mockInterface
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testMovieSectionIs1() {
        presenter?.refreshMovieList(with: fakeMovies)
        XCTAssertEqual(presenter?.sections, 1)
    }
    
    func testMovieCountIs1() {
        presenter?.refreshMovieList(with: fakeMovies)
        XCTAssertEqual(presenter?.movieCount, 1)
    }
    
    func testMoveAtIndexIsInjectedMovie() {
        presenter?.refreshMovieList(with: fakeMovies)
        let movie = presenter?.movie(at: 0)
        XCTAssertEqual(movie?.name, fakeMovies[0].name)
        XCTAssertEqual(movie?.rating, fakeMovies[0].rating)
    }
    
    func testMovieListEmptyShouldShowError() {
        presenter?.refreshMovieList(with: [])
        XCTAssertEqual(mockInterface?.shouldShowError,
                       true)
        XCTAssertEqual(mockInterface?.shouldLoadMovieListWithMovies,
                       false)
    }
    
    func testMovieListEmptyShouldShowMovie() {
        presenter?.refreshMovieList(with: fakeMovies)
        XCTAssertEqual(mockInterface?.shouldShowError,
                       false)
        XCTAssertEqual(mockInterface?.shouldLoadMovieListWithMovies,
                       true)
    }
    
    func testSelectedMovie() {
        presenter?.refreshMovieList(with: fakeMovies)
        presenter?.selectMovie(fakeMovies[0])
        XCTAssertEqual(mockRouter.movie?.name, fakeMovies[0].name)
    }
}

