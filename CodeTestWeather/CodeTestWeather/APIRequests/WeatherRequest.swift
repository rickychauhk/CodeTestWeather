//
//  WeatherRequest.swift
//  CodeTestWeather
//
//  Created by Ricky on 17/7/2021.
//

import Foundation
import Alamofire

struct WeatherRequest: EndPointType {
    
    let city: String
    let units: String = "metric"
    var latitude: String = ""
    var longitude: String = ""
    
    init(city: String, latitude: String, longitude: String) {
        self.city = city
        self.latitude = !city.isEmpty ? "" : latitude
        self.longitude = !city.isEmpty ? "" : longitude
    }
    
    var query: String {
        let params = ["q": city,
                      "lon": longitude,
                      "lat": latitude,
                      "units": units,
                      "APPID":Constants.AppID]
        var output: String = ""
        for (key,value) in params {
            output +=  "\(key)=\(value)&"
        }
        output = String(output.dropLast())
        return output
        
    }
    var params: [String : Any]?{
        return nil
    }
    
    
    var path: String {
        return "data/2.5/weather?"
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
}
