//
//  Drink.swift
//  TheCocktailDB
//
//  Created by Admin on 5/23/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation
import UIKit

struct Drink {
    // General Info
    var id: String?
    var name: String?
    var tagList: String?
    var tags: [String] {
        if tagList == nil {
            return []
        } else {
            return tagList!.components(separatedBy: ",")
        }
    }
    var category: String?
    var alcoholic: String?
    var glass: String?
    var instructions: String?
    var image: String?
    var creative: String?
    var ingredients: [(String, String)]?
}
