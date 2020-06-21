//
//  MainViewController.swift
//  hw44-weather
//
//  Created by Admin on 6/20/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var weatherImg: UIImageView!
    @IBOutlet weak var currentState: UILabel!
    @IBOutlet weak var currentHum: UILabel!
    @IBOutlet weak var currentPress: UILabel!
    @IBOutlet weak var todayMax: UILabel!
    @IBOutlet weak var todayMin: UILabel!
    @IBOutlet weak var forecastBtn: UIButton!
    
    let locationManager = CLLocationManager()
    
    var currentLocation: CLLocation?
    
    let service = APIService()
    
    let currentViewModel = CurrentViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        checkLocationServiceEnabled()
        forecastBtn.layer.cornerRadius = 10
        
        
        
        
    }
    
    @IBAction func seeForecast(_ sender: UIButton) {
        performSegue(withIdentifier: "show_forecast", sender: nil)
    }

    private func checkLocationServiceEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkAuthorizationStatus()
            self.currentLocation = locationManager.location
        } else {
        }
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    private func checkAuthorizationStatus() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .authorizedAlways:
            break
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        @unknown default:
            print("")
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        self.currentLocation = location
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            currentViewModel.getCurrentWeather(location.coordinate.latitude, location.coordinate.longitude) { (weather, img) in
                DispatchQueue.main.async {
                    self.cityName.text = weather.name
                    self.currentTemp.text = String(format: "%.0f", weather.main.temp - 273.15) + "°C"
                    self.currentState.text = weather.weather[0].main
                    self.currentHum.text = "Humidity: \(String(weather.main.humidity))%"
                    self.currentPress.text = "Pressure: \(String(weather.main.pressure))"
                    self.todayMax.text = "Maximum temp: \(String(format: "%.0f", weather.main.tempMax - 273.15))°C"
                    self.todayMin.text = "Minimum temp: \(String(format: "%.0f", weather.main.tempMin - 273.15))°C"
                    self.weatherImg.image = img
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationManager.startUpdatingLocation()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "show_forecast" {
            if let forecastVC = segue.destination as? ForecastViewController {
                forecastVC.lat = currentLocation!.coordinate.latitude
                forecastVC.lon = currentLocation!.coordinate.longitude
            }
        }
    }
}
