//
//  MovieCell.swift
//  MovieVapp
//
//  Created by Haiyan Ma on 01/12/2017.
//  Copyright © 2017 Haiyan Ma. All rights reserved.
//

import UIKit

class MovieCell: BaseCell {

    let titleLabel: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 1
        lb.lineBreakMode = .byTruncatingTail
        return lb
    }()

    let bottomSeparationLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.themePurple()
        return view
    }()

    override func setupViews() {
        super.setupViews()
        addSubViewList(titleLabel, bottomSeparationLine)
        titleLabel.anchorWithConstantsToTop(topAnchor,
                                            left: leftAnchor,
                                            bottom: bottomAnchor,
                                            right: rightAnchor,
                                            topConstant: 0,
                                            leftConstant: 16,
                                            bottomConstant: 0, rightConstant: 16)
        bottomSeparationLine.anchorToTop(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        bottomSeparationLine.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
    }

    func configCell(_ movie: Movie?) {
        titleLabel.text = movie?.name
    }
}
