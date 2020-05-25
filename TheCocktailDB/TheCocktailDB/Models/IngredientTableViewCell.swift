//
//  IngredientTableViewCell.swift
//  TheCocktailDB
//
//  Created by Admin on 5/25/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {

    @IBOutlet weak var ingredientName: UILabel!
    @IBOutlet weak var ingredientMeasure: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
