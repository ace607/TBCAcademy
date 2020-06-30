//
//  DrinkViewModel.swift
//  hw43-2
//
//  Created by Admin on 6/22/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class DrinkViewModel {
    var getDrinksForCategories = { (category: String, completion: @escaping ([(Drink, UIImage)]) -> ()) in
        let service = APIService()
        var drinks = [(Drink, UIImage)]()
        
        
        service.fetchCategory(category: category) { (category) in
            category.drinks.forEach { (categoryDrink) in
                
                service.fetchDrink(id: categoryDrink.id) { (drink) in
                    drink.image.downloadImage { (img) in
                        drinks.append((drink, img!))
                        DispatchQueue.main.async {
                            completion(drinks)
                        }
                    }
                }
            }
        }
        
        
    }
}
