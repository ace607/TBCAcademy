//
//  SearchAlbumCollectionViewCell.swift
//  hw46-music-app
//
//  Created by Admin on 6/24/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class SearchAlbumCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var albumImg: UIImageView!
    @IBOutlet weak var albumTitle: UILabel!
    @IBOutlet weak var albumArtist: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        albumImg.layer.cornerRadius = 15
    }

}
