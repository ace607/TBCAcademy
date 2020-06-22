//
//  DrinkCollectionViewCell.swift
//  hw43-2
//
//  Created by Admin on 6/22/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class DrinkCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var drinkImg: UIImageView!
    @IBOutlet weak var drinkName: UILabel!
    @IBOutlet weak var drinkNameView: UIView!
    
    var drink: (Drink, UIImage)! {
        didSet {
            self.drinkImg.image = drink.1
            self.drinkName.text = drink.0.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
        drinkNameView.backgroundColor = .clear
        let gradientLayer = CAGradientLayer();
        gradientLayer.frame = drinkNameView.bounds;
        gradientLayer.startPoint = CGPoint(x: 0.5,y: 0.0);
        gradientLayer.endPoint = CGPoint(x: 0.5,y: 1.0);
        gradientLayer.locations = [0.0, 0.2, 1.0];
        gradientLayer.colors = [UIColor.black.withAlphaComponent(0).cgColor,
                                UIColor.black.withAlphaComponent(0.7).cgColor,
                                UIColor.black.withAlphaComponent(1).cgColor];
        drinkNameView.layer.insertSublayer(gradientLayer, below: drinkName.layer)
    }
}
