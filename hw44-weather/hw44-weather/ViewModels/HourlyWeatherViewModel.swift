//
//  CurrentViewModel.swift
//  hw44-weather
//
//  Created by Admin on 6/21/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit
import CoreLocation

class HourlyWeatherViewModel {
    public var getHourlyWeather = { (_ lat: Double,_ lon: Double, completion: @escaping (WeatherList, [UIImage], [String]) -> ()) in
        let service = APIService()
        service.fetchHourlyWeather(lat: lat, lon: lon) { (weathers) in
            var imgs = [UIImage]()
            var rowsForSection = [Int]()
            var weekDays = [String]()
            var timezone: TimeZone?
            let location = CLLocation(latitude: lat, longitude: lon)
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(location) { (placemarks, err) in
                 if let placemark = placemarks?[0] {
                    timezone = placemark.timeZone
                 }
            }
            
            for w in weathers.list.enumerated() {
                let date = Date(timeIntervalSince1970: Double(w.element.dt))
                let dateFormatter = DateFormatter()
                dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
                dateFormatter.locale = NSLocale.current
                dateFormatter.dateFormat = "EEEE" //Specify your format that you want
                let strDate = dateFormatter.string(from: date)
                weekDays.append(strDate)
            }
            
            for w in weathers.list.enumerated() {
                let url = "http://openweathermap.org/img/wn/\(w.element.weather[0].icon)@4x.png"
                url.downloadImage{ (img) in
                    imgs.append(img!)
                    if imgs.count == weathers.list.count {
                        completion(weathers, imgs, weekDays)
                    }
                }
            }
        }
    }
}
