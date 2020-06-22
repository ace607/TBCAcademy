//
//  Drink.swift
//  hw43-2
//
//  Created by Admin on 6/22/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation

struct Drink: Codable {
    var id: String
    var name: String
    var category: String
    var image: String
    var ing1: String?
    var ing2: String?
    var ing3: String?
    var ing4: String?
    var ing5: String?
    var ing6: String?
    var ing7: String?
    var ing8: String?
    var ing9: String?
    var ing10: String?
    var ing11: String?
    var ing12: String?
    var ing13: String?
    var ing14: String?
    var ing15: String?
    
    var ingredientList: [String] {
        return [ing1, ing2, ing3, ing4, ing5, ing6, ing7, ing8, ing9, ing10, ing11, ing12, ing13, ing14, ing15].filter { $0 != nil }.map { $0! }
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case name = "strDrink"
        case category = "strCategory"
        case image = "strDrinkThumb"
        case ing1 = "strIngredient1"
        case ing2 = "strIngredient2"
        case ing3 = "strIngredient3"
        case ing4 = "strIngredient4"
        case ing5 = "strIngredient5"
        case ing6 = "strIngredient6"
        case ing7 = "strIngredient7"
        case ing8 = "strIngredient8"
        case ing9 = "strIngredient9"
        case ing10 = "strIngredient10"
        case ing11 = "strIngredient11"
        case ing12 = "strIngredient12"
        case ing13 = "strIngredient13"
        case ing14 = "strIngredient14"
        case ing15 = "strIngredient15"
    }
}

