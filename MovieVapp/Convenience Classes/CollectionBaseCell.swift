//
//  CollectionViewBaseCell.swift
//  MovieVapp
//
//  Created by Haiyan Ma on 17/12/2017.
//  Copyright © 2017 Haiyan Ma. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    func setupViews() {
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
