//
//  Playlist.swift
//  hw46-music-app
//
//  Created by Admin on 6/23/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation


struct Playlist: Codable {
    var id: Int
    var title: String
    var picture: String
    var creator: Creator
    var tracks: Tracks
    
    enum CodingKeys: String, CodingKey {
        case id, title, creator, tracks
        case picture = "picture_medium"
        
    }
}

struct Creator: Codable {
    var id: Int
    var name: String
}

struct Tracks: Codable {
    var data: [Track]
}
