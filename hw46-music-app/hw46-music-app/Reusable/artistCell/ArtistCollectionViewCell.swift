//
//  ArtistCollectionViewCell.swift
//  hw46-music-app
//
//  Created by Admin on 6/24/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class ArtistCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var artistPhoto: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        artistPhoto.layer.cornerRadius = 15
    }

}
