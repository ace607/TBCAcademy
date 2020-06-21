//
//  weatherModel.swift
//  hw44-weather
//
//  Created by Admin on 6/20/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation

struct currentWeather: Codable {
    var coord: Coord
    var weather: [WeatherInfo]
    var main: MainInfo
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case coord
        case weather
        case main
        case name = "name"
    }
}

struct Coord: Codable {
    var lat: Double
    var lon: Double
}

struct WeatherInfo: Codable {
    var main: String
    var description: String
    var icon: String
}

struct MainInfo: Codable {
    var temp: Double
    var pressure: Int
    var humidity: Int
    var tempMin: Double
    var tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case pressure
        case humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}
