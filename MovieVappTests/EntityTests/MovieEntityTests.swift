//
//  MovieVappTests.swift
//  MovieVappTests
//
//  Created by Haiyan Ma on 01/12/2017.
//  Copyright © 2017 Haiyan Ma. All rights reserved.
//

import XCTest
@testable import MovieVapp

class MovieEntityTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    func testMovieSetGet() {
        let movie = Movie(name: "Interstella", rating: 5, imageName: "avatar")
        XCTAssertEqual(movie.name, "Interstella")
        XCTAssertEqual(movie.rating, 5)
    }
}
