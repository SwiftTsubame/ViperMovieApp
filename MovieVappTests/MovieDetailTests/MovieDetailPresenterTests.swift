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

    class MockInteractor: MovieDetailInteraction {
        var movie: Movie?
        var toggleFavoriteCalled = false
        func toggleFavorite() {
            toggleFavoriteCalled = true
        }
    }
    
    class MockRouter: MovieDetailRouting {
        
    }
    
    class MockInterface: MovieDetailViewInterface {
        var presenter: MovieDetailPresentation?
        
        var shouldShowNoMovieError = false
        var shouldShowMovieDetail = false

        func showNoMovieError() {
            shouldShowNoMovieError = true
        }
        
        func showMovieDetail(movie: Movie) {
            shouldShowMovieDetail = true
        }
    }
    
    
    var mockInteractor = MockInteractor()
    var mockRouter = MockRouter()
    var mockInterface = MockInterface()
    override func setUp() {
        super.setUp()
        movieDetailPresenter = MovieDetailPresenter(interactor: mockInteractor, router: mockRouter)
        movieDetailPresenter.viewInterface = mockInterface
    }
    
    override func tearDown() {
        mockInterface = MockInterface()
        super.tearDown()
    }
    
    func testViewInterfaceShowErrorWhenNoMovie() {
        mockInteractor.movie = nil
        movieDetailPresenter.prepareToShowMovieDetail()
        XCTAssertEqual(mockInterface.shouldShowNoMovieError, true)
        XCTAssertEqual(mockInterface.shouldShowMovieDetail, false)
    }
    
    func testViewInterfaceShowMovieWhenSuccess() {
        mockInteractor.movie = Movie(name: "abc", rating: 4)
        movieDetailPresenter.prepareToShowMovieDetail()
        XCTAssertEqual(mockInterface.shouldShowNoMovieError, false)
        XCTAssertEqual(mockInterface.shouldShowMovieDetail, true)
    }
    
    func testToggleFavoriteWillTriggerInteractorToggleCall() {
        XCTAssertEqual(mockInteractor.toggleFavoriteCalled, false)
        movieDetailPresenter.toggleFavorite()
        XCTAssertEqual(mockInteractor.toggleFavoriteCalled, true)
    }
    
    func testIsFavoriteValueAgreesWithInteractorMovieValue() {
        mockInteractor.movie = Movie(name: "abc", rating: 4)
        XCTAssertEqual(movieDetailPresenter.isFavorite, false)
        
        mockInteractor.movie = Movie(name: "abc", rating: 4, isFavorite: true)
        XCTAssertEqual(movieDetailPresenter.isFavorite, true)
    }
}

