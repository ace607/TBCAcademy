//
//  CharactersCollectionViewCell.swift
//  hw54-carousel
//
//  Created by Admin on 7/5/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class CharactersCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.borderColor = UIColor.blue.cgColor
        self.contentView.layer.borderWidth = 2
        self.contentView.layer.masksToBounds = true
          
            self.contentView.layer.shouldRasterize = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = self.frame.inset(by: UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0))
    }
}
