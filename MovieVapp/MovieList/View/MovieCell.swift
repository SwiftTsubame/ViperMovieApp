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
    
    let favoriteImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()

    let bottomSeparationLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.themePurple()
        return view
    }()

    override func setupViews() {
        super.setupViews()
        addSubViewList(titleLabel, bottomSeparationLine, favoriteImageView)
        titleLabel.anchorWithConstantsToTop(topAnchor,
                                            left: leftAnchor,
                                            bottom: bottomAnchor,
                                            right: rightAnchor,
                                            topConstant: 0,
                                            leftConstant: 16,
                                            bottomConstant: 0,
                                            rightConstant: 16)
        
        _ = favoriteImageView.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 16, widthConstant: 30, heightConstant: 30)
        favoriteImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        bottomSeparationLine.anchorToTop(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        bottomSeparationLine.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
    }

    func configCell(_ movie: Movie?) {
        titleLabel.text = movie?.name
        favoriteImageView.image = movie?.isFavorite == true ? #imageLiteral(resourceName: "heart") : #imageLiteral(resourceName: "emptyHeart")
    }
}
