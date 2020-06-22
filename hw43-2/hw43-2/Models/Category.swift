//
//  Category.swift
//  hw43-2
//
//  Created by Admin on 6/22/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation

struct Categories: Codable {
    var drinks: [CategoryDrink]
}

struct CategoryDrink: Codable {
    var id: String
    enum CodingKeys: String, CodingKey {
        case id = "idDrink"
    }
}
