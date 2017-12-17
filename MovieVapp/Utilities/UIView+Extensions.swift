//
//  UIView+Anchors.swift
//  MovieVapp
//
//  Created by Haiyan Ma on 01/12/2017.
//  Copyright © 2017 Haiyan Ma. All rights reserved.
//

import UIKit

extension UIView {

    public func addSubViewList(_ view: UIView...) {
        view.forEach { self.addSubview($0)}
    }

    public func fillSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
            rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
            topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        }
    }

    public func anchorToTop(top: NSLayoutYAxisAnchor? = nil,
                            left: NSLayoutXAxisAnchor? = nil,
                            bottom: NSLayoutYAxisAnchor? = nil,
                            right: NSLayoutXAxisAnchor? = nil) {
        anchorWithConstantsToTop(top,
                                 left: left,
                                 bottom: bottom,
                                 right: right,
                                 topConstant: 0,
                                 leftConstant: 0,
                                 bottomConstant: 0,
                                 rightConstant: 0)
    }

    public func anchorWithConstantsToTop(_ top: NSLayoutYAxisAnchor? = nil,
                                         left: NSLayoutXAxisAnchor? = nil,
                                         bottom: NSLayoutYAxisAnchor? = nil,
                                         right: NSLayoutXAxisAnchor? = nil,
                                         topConstant: CGFloat = 0,
                                         leftConstant: CGFloat = 0,
                                         bottomConstant: CGFloat = 0,
                                         rightConstant: CGFloat = 0) {

        _ = anchor(top: top,
                   left: left,
                   bottom: bottom,
                   right: right,
                   topConstant: topConstant,
                   leftConstant: leftConstant,
                   bottomConstant: bottomConstant,
                   rightConstant: rightConstant)
    }

    public func anchor(top: NSLayoutYAxisAnchor? = nil,
                       left: NSLayoutXAxisAnchor? = nil,
                       bottom: NSLayoutYAxisAnchor? = nil,
                       right: NSLayoutXAxisAnchor? = nil,
                       topConstant: CGFloat = 0,
                       leftConstant: CGFloat = 0,
                       bottomConstant: CGFloat = 0,
                       rightConstant: CGFloat = 0,
                       widthConstant: CGFloat = 0,
                       heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false

        var anchors = [NSLayoutConstraint]()

        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }

        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }

        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }

        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
        }

        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }

        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }

        anchors.forEach({$0.isActive = true})
        return anchors
    }
}
