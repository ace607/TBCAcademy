//
//  book.swift
//  books
//
//  Created by Admin on 4/30/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation

class book {
    var title: String?
    var author: String?
    var price: Int?
    var image: String?
    
    init(title: String, author: String, price: Int, image: String) {
        self.title = title
        self.author = author
        self.price = price
        self.image = image
    }
}
