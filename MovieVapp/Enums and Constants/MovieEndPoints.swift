//
//  MovieEndPoints.swift
//  MovieVapp
//
//  Created by Haiyan Ma on 04/12/2017.
//  Copyright © 2017 Haiyan Ma. All rights reserved.
//

import Foundation

struct APIBuilder {
    static let ApiScheme = "https"
    static let ApiHost = "s3.amazonaws.com"
    static let ApiPath = "/myMovieViperApp"
}

enum Endpoint: String {
    case movieList, favoriteMovies
}
