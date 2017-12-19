//
//  MovieCell.swift
//  MovieVapp
//
//  Created by Haiyan Ma on 01/12/2017.
//  Copyright © 2017 Haiyan Ma. All rights reserved.
//

import UIKit

protocol CellInterfaceDelegate: class {
    func toggleFavoriteMovie(at index: Int)
}

class MovieCell: BaseCell {

    let titleLabel: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.lineBreakMode = .byTruncatingTail
        lb.textAlignment = .center
        lb.textColor = .white
        lb.font = UIFont.boldSystemFont(ofSize: 15)
        lb.backgroundColor = UIColor(white: 0.4, alpha: 0.7)
        return lb
    }()
    
    lazy var favoriteImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapFavorite)))
        return iv
    }()

    let backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()

    weak var cellInterfaceDelegate: CellInterfaceDelegate?

    private var movie: Movie?

    override func setupViews() {
        super.setupViews()

        configCellLayer()
        addSubViewList(backgroundImageView, titleLabel, favoriteImageView)
        
        backgroundImageView.fillSuperview()

        titleLabel.anchorWithConstantsToTop(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 8, rightConstant: 0)
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        _ = favoriteImageView.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 8, widthConstant: 28, heightConstant: 28)
    }

    func configCell(_ movie: Movie?) {
        self.movie = movie
        titleLabel.text = movie?.name
        setFavoriteImage(for: movie)
        guard let imageName = movie?.imageName else { return }
        backgroundImageView.image = UIImage(named: imageName)
    }

    @objc func handleTapFavorite() {
        setFavoriteImage(for: self.movie)
        cellInterfaceDelegate?.toggleFavoriteMovie(at: tag)
    }

    private func configCellLayer() {
        layer.cornerRadius = 6
        layer.masksToBounds = true
    }

    private func setFavoriteImage(for movie: Movie?) {
        favoriteImageView.image = movie?.isFavorite == true ? #imageLiteral(resourceName: "heart") : #imageLiteral(resourceName: "emptyHeart")
    }
}
