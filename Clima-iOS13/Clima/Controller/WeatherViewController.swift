//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchField: UITextField!
    let locationManager : CLLocationManager = CLLocationManager()
    var weatherManager : WeatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.requestLocation()
        weatherManager.delegate = self
        searchField.delegate = self
    }
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        print(searchField.text!)
        searchField.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate
extension WeatherViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if(searchField.text == nil || searchField.text == ""){
            searchField.placeholder = "Type Something"
            return false
        } else{
            searchField.placeholder = "Search"
            return true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let city : String = searchField.text  ?? "London"
        weatherManager.fetchWeather(cityName: city)
        searchField.text = ""
    }
}

// MARK: - weather manager delegate
extension WeatherViewController : WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager : WeatherManager ,weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.cityLabel.text = weather.cityName
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        }
    }
    
    func didFailWithError(error: Error) {
        print("error")
    }
}


// MARK: - location Manager
extension WeatherViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            locationManager.stopUpdatingLocation()
            let lat : CLLocationDegrees  = lastLocation.coordinate.latitude
            let long : CLLocationDegrees = lastLocation.coordinate.longitude
            
            weatherManager.fetchWeather(lattitude: lat, longitude: long)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error")
    }
}

