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
    @IBOutlet weak var searchBox: UITextField!

    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self //must WVC must adopt location manager to do anything
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        weatherManager.delegate = self //weather manager's delegate property is not nil
        searchBox.delegate = self
    }
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}
//MARK: - UITextFieldDelegate
    extension WeatherViewController: UITextFieldDelegate{
        @IBAction func searchPressed(_ sender: UIButton) {
            print("You typed \(searchBox.text!)")
            searchBox.endEditing(true)
        }
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            print(searchBox.text!)
            return textFieldShouldEndEditing(searchBox)
        }
        func textFieldDidEndEditing(_ textField: UITextField) {
            if let city = searchBox.text{
                weatherManager.fetchWeather(cityName: city)
            }
            searchBox.text = ""
        }
        //useful for doing validation on the text.
        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            if searchBox.text! != "" {
                return true
            } else {
                searchBox.placeholder = "Type something"
                return false
            }
        }
    }
//MARK: - WeatherManagerDelegate
    extension WeatherViewController: WeatherManagerDelegate {
        func didUpdateWeather(_ weatherManager : WeatherManager, weather : WeatherModel) {
            DispatchQueue.main.async {
                self.temperatureLabel.text = weather.temperatureString
                self.conditionImageView.image = UIImage(systemName: weather.conditionName)
                self.cityLabel.text = weather.cityName
            }
        }
        func didFailWithError(error: Error) {
            print(error)
        }
        
    }

//MARK: - LocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Got Location")
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude : lat, longitude : lon)
            
        }
        }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    }


