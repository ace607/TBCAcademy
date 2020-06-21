//
//  hourlyWeatherModel.swift
//  hw44-weather
//
//  Created by Admin on 6/21/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation

struct WeatherList: Codable {
    var list: [HourlyWeather]
}

struct HourlyWeather: Codable {
    var dt: Int
    var main: mainInfo
    var weather: [Weather]
}

struct mainInfo: Codable {
    var temp: Double
}

struct Weather: Codable {
    var main: String
    var description: String
    var icon: String
}
