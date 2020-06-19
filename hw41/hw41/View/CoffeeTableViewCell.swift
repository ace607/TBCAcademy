//
//  CoffeeTableViewCell.swift
//  hw41
//
//  Created by Admin on 6/16/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class CoffeeTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    
    var coffee: Coffee! {
        didSet {
            name.text = coffee.name
            price.text = coffee.priceText
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
