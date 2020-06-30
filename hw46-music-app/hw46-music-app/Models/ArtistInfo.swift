//
//  ArtistInfo.swift
//  hw46-music-app
//
//  Created by Admin on 6/24/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation

struct ArtistInfo: Codable {
    var id: Int
    var name: String
    var img: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case img = "picture_medium"
    }
}
