//
//  SearchResponse.swift
//  hw46-music-app
//
//  Created by Admin on 6/24/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation

struct SearchResponse: Codable {
    var data: [Track]
}

struct SearchAlbumResponse: Codable {
    var data: [AlbumSearchObject]
}

struct AlbumSearchObject: Codable {
    var id: Int
    var title: String
    var cover: String
    var artist: Artist
    
    enum CodingKeys: String, CodingKey {
        case id, title, artist
        case cover = "cover_medium"
    }
}
