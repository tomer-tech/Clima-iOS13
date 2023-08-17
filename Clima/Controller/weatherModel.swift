//
//  weatherModel.swift
//  Clima
//
//  Created by Ankhe Tomer on 5/2/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
struct WeatherModel {
    let conditionID: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    
    //a computed property as opposed to a stored property
    var conditionName: String{
        switch conditionID {
        case 200...299 :
            return "cloud.bolt"
        case 300...399 :
            return "cloud.drizzle"
        case 500...599 :
            return "cloud.rain"
        case 600...699 :
            return "cloud.snow"
        case 700...799 :
            return "cloud.fog"
        case 800 :
            return "sun.max"
        case 801...899 :
            return "cloud.bolt"
        
        default :
            return "cloud"
        }
        
    }

}
