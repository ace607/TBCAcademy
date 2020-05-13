//
//  podcastTableViewCell.swift
//  podcasts
//
//  Created by Admin on 5/13/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class podcastTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
