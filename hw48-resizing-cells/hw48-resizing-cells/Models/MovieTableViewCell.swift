//
//  MovieTableViewCell.swift
//  hw48-resizing-cells
//
//  Created by Admin on 6/29/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieText: UILabel!
    @IBOutlet weak var imgHeight: NSLayoutConstraint!
    
    var isSelectedMovie = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgHeight.constant = (self.frame.width - 40) * 1.4
        moviePoster.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
