//
//  ForecastTableViewCell.swift
//  hw44-weather
//
//  Created by Admin on 6/20/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var weatherImg: UIImageView!
    @IBOutlet weak var weatherState: UILabel!
    @IBOutlet weak var weatherDegrees: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
