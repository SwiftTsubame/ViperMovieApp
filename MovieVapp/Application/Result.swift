//
//  Result.swift
//  MovieVapp
//
//  Created by Haiyan Ma on 04/12/2017.
//  Copyright © 2017 Haiyan Ma. All rights reserved.
//

import Foundation

public enum MovieErrorType: Error {
    case noInternet
}

enum Result<T> {
    case success(T)
    case failure(MovieErrorType)
}
