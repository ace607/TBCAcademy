//
//  IngredientDrinkTableViewCell.swift
//  TheCocktailDB
//
//  Created by Admin on 5/27/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class IngredientDrinkTableViewCell: UITableViewCell {
    @IBOutlet weak var drinkImage: UIImageView!
    @IBOutlet weak var drinkName: UILabel!
    @IBOutlet weak var drinkCategory: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
