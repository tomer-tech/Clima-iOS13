//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate //allows class "weatherviewcontroller" to manage the editing and validation of text in a text field
{

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchBox: UITextField!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //searchtextfield.delegate property
        //text field reports back to ViewController with user activity including starting typing, stopping typing, and tapping elsewhere on the screen
        weatherManager.delegate = self //weather manager's delegate property is not nil
        searchBox.delegate = self
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        print("You typed \(searchBox.text!)")
        searchBox.endEditing(true)

    }
    
    //what happens when you press return on keyboard. return true to execute.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(searchBox.text!)
        return textFieldShouldEndEditing(searchBox)
        
    }
    
    //what happens when the text fields on the screen are done with editing
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

