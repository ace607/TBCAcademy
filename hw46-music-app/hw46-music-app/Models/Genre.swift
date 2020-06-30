//
//  Genre.swift
//  hw46-music-app
//
//  Created by Admin on 6/24/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation

struct Genre: Codable {
    var id: Int
    var name: String
}

struct GenreList: Codable {
    var data: [Genre]
}
