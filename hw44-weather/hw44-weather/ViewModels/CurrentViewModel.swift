//
//  CurrentViewModel.swift
//  hw44-weather
//
//  Created by Admin on 6/21/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit
import CoreLocation

class CurrentViewModel {
    public var getCurrentWeather = { (_ lat: Double,_ lon: Double, completion: @escaping (currentWeather, UIImage) -> ()) in
        let service = APIService()
        service.fetchCurrentWeather(lat: lat, lon: lon) { (weather) in
            let url = "http://openweathermap.org/img/wn/\(weather.weather[0].icon)@4x.png"
                url.downloadImage{ (img) in
                    completion(weather, img!)
                }
        }
    }
}
