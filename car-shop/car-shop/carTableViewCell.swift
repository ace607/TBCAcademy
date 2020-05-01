//
//  carTableViewCell.swift
//  car-shop
//
//  Created by Admin on 5/1/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class carTableViewCell: UITableViewCell {

    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var carModel: UILabel!
    @IBOutlet weak var carYear: UILabel!
    @IBOutlet weak var carPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
