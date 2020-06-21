//
//  ForecastViewController.swift
//  hw44-weather
//
//  Created by Admin on 6/20/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit
import CoreLocation

class ForecastViewController: UIViewController {
    @IBOutlet weak var forecastTable: UITableView!
    
    let hourlyWeatherViewModel = HourlyWeatherViewModel()
    
    var lat: Double?
    var lon: Double?
    
    var weatherList = [(HourlyWeather, UIImage, String)]()
    
    var timeZone: TimeZone?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let location = CLLocation(latitude: lat!, longitude: lon!)
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location) { (placemarks, err) in
             if let placemark = placemarks?[0] {
                self.timeZone = placemark.timeZone
             }
        }
        forecastTable.delegate = self
        forecastTable.dataSource = self
        hourlyWeatherViewModel.getHourlyWeather(lat!, lon!) { (weathers, imgs, weeks) in
            for w in weathers.list.enumerated() {
                self.weatherList.append((w.element, imgs[w.offset], weeks[w.offset]))
            }
            DispatchQueue.main.async {
                self.forecastTable.reloadData()
            }
        }
    }
    
    @IBAction func onClose(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    

}

extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let weeks = Array(NSOrderedSet(array: weatherList.map { $0.2 })) as! [String]
        return weeks.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let weeks = Array(NSOrderedSet(array: weatherList.map { $0.2 })) as! [String]
        
        return weatherList.filter { $0.2 == weeks[section] }.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = forecastTable.dequeueReusableCell(withIdentifier: "forecast_cell", for: indexPath) as! ForecastTableViewCell
        
        let weeks = Array(NSOrderedSet(array: weatherList.map { $0.2 })) as! [String]
        let weathers = weatherList.filter { $0.2 == weeks[indexPath.section] }
        
        let date = Date(timeIntervalSince1970: Double(weathers[indexPath.row].0.dt))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        cell.hourLabel.text = strDate
        
        cell.weatherImg.image = weathers[indexPath.row].1
        cell.weatherState.text = weathers[indexPath.row].0.weather[0].main
        cell.weatherDegrees.text =  String(format: "%.0f", weathers[indexPath.row].0.main.temp - 273.15) + "°C"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let weeks = Array(NSOrderedSet(array: weatherList.map { $0.2 })) as! [String]
        return weeks[section]
    }
}
