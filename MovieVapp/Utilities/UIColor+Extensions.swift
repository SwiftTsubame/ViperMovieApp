//
//  UIColor+Extensions.swift
//  MovieVapp
//
//  Created by Haiyan Ma on 05/12/2017.
//  Copyright © 2017 Haiyan Ma. All rights reserved.
//

import UIKit

extension UIColor {

    static func rgb(_ red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }

    static func themePurple() -> UIColor {
        return rgb(108, green: 16, blue: 124)
    }
}
