//
//  categoryCell.swift
//  photo-gallery
//
//  Created by Admin on 5/5/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class categoryCell: UICollectionViewCell {
    let photo: UIImageView = {
        let image = UIImageView()
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(photo)
        NSLayoutConstraint.activate([
            photo.topAnchor.constraint(equalTo: topAnchor),
            photo.bottomAnchor.constraint(equalTo: bottomAnchor),
            photo.leadingAnchor.constraint(equalTo: leadingAnchor),
            photo.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
