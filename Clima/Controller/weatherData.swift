//
//  weatherData.swift
//  Clima
//
//  Created by Ankhe Tomer on 4/23/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData : Decodable{
    let name: String
    let weather: [Weather]
    let main: Main
    
}

struct Weather : Decodable{
    let description: String
    let id : Int
    let main : String
    let icon : String
}

struct Main : Decodable{
    let temp: Double
    let pressure: Int
    let humidity: Int
    let temp_min: Double
    let temp_max: Double
}


