//
//  Character.swift
//  hw54-carousel
//
//  Created by Admin on 7/5/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation

struct Character: Codable {
    var id: Int
    var name: String
    var occupation: [String]
    var nickname: String
    var img: String
    var birthday: String
    
    enum CodingKeys: String, CodingKey {
        case name, occupation, nickname, img, birthday
        case id = "char_id"
    }
}
