//
//  Constants.swift
//  CodeTestWeather
//
//  Created by Ricky on 17/7/2021.
//

import Foundation

class Constants {
    
    static let AppID = "95d190a434083879a6398aafd54d9e73"
    
    static func isNilOrEmpty(string: String?) -> Bool {
        guard let value = string else { return true }
        
        return value.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    static let storeKey = "storedCities"
    
    static let baseUrl = "https://api.openweathermap.org/"
    
    static let basePath = "data/2.5/weather?"
    
    static let temperatureTitle = "Temperature:"
    
    static let humidity = "Humidity:"
    
    static let detailViewId = "detailsviewcontrollerseg"
}

