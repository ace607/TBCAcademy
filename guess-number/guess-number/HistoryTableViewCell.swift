//
//  HistoryTableViewCell.swift
//  guess-number
//
//  Created by Admin on 5/22/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var numLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


