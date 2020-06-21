//
//  APIService.swift
//  hw44-weather
//
//  Created by Admin on 6/20/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation

class APIService {
    func fetchCurrentWeather(lat: Double, lon: Double, completion: @escaping (currentWeather) -> ()){
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=af2edb08b5beeacd412aa87266aea78d") else {return}
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            guard let data = data else {return}
            do {
                let decoder = JSONDecoder()
                let weather = try decoder.decode(currentWeather.self, from: data)
                completion(weather)
            } catch {print(error)}
        }.resume()
    }
    
    func fetchHourlyWeather(lat: Double, lon: Double, completion: @escaping (WeatherList) -> ()){
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=af2edb08b5beeacd412aa87266aea78d") else {return}
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            guard let data = data else {return}
            do {
                let decoder = JSONDecoder()
                let weathers = try decoder.decode(WeatherList.self, from: data)
                completion(weathers)
            } catch {print(error)}
        }.resume()
    }
}
