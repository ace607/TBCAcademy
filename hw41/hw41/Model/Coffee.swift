//
//  Coffee.swift
//  hw41
//
//  Created by Admin on 6/17/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

struct Coffee: Codable {
    var name: String
    var image: String
    var price: Double
    var priceText: String {
        return "$\(price)"
    }
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case image = "Photo"
        case price = "Price"
    }
}

struct CoffeeList: Codable {
    var list: [Coffee]
    
    enum CodingKeys: String, CodingKey {
        case list = "List"
    }

}
