//
//  wetherManager.swift
//  Clima
//
//  Created by Ankhe Tomer on 4/19/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager : WeatherManager, weather : WeatherModel) // reqirements of protocol
    func didFailWithError(error: Error)
}


struct WeatherManager{
    // add these programmitaclly : q=new%20york&units=imperial"
    // var location
    // var units
    // somerthing else maybe
    var weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=36a8728aa9e41f58f4fa8dcc4050ffa4&"
    var delegate : WeatherManagerDelegate? //set delegate as an optional wmd.
    
    func fetchWeather(cityName : String) { //method takes input called cityname which is a string data type
        let urlString = "\(weatherURL)&q=\(cityName)&units=imperial" //urlstring for the specific city and imperial temp display
        performRequest(with: urlString)}
    
    func performRequest(with urlString: String) {  //do networking
        if let url = URL(string: urlString) { //optinal binding
            let session = URLSession(configuration: .default) //create URLSession
            //give session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return}
                if let safeData = data {
                    if let weather = parseJSON(weatherData: safeData){
                        self.delegate?.didUpdateWeather(self, weather: weather) //inside closure, delegate needs self keyword
                    }
                }
                
            }
                task.resume()//Start Task
            }
        
        
        func parseJSON(weatherData: Data) -> WeatherModel? {
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
                let id = decodedData.weather[0].id
                let temp = decodedData.main.temp
                let name = decodedData.name
                
                //create a weather object from the weatherModel
                let weather = WeatherModel(conditionID: id, cityName: name, temperature: temp)
                print("The weather is \(weather.conditionName) right now")
                print("It is \(weather.temperatureString) degrees right now")
                return weather
                
            } catch {
                delegate?.didFailWithError(error: error)
                return nil //weather model must be optional to possibly set something as nil
            }
        }
        
    }
    
}
