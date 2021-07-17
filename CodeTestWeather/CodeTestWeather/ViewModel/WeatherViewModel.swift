//
//  WeatherViewModel.swift
//  CodeTestWeather
//
//  Created by Ricky on 17/7/2021.
//

import Foundation

class WeatherViewModel {
    
    static let shared = WeatherViewModel()
    var weather: [Weather] = []
    
    var dataLoadSuccessfully: (() -> Void)? = nil

    func getWeatherData(city: String, lat: String, lon: String){
        let request = WeatherRequest(city: city, latitude: lat, longitude: lon)
        APIManager.shared().request(type: request) { [weak self] (result: ResultResponse<Weather>)  in
            
            switch result{
            case .success(let data):
                self?.weather.append(data)
                self?.dataLoadSuccessfully?()
                
            case .failure(let error):

                debugPrint(error?.errorMessage ?? "Error fetching data")
                
            }
        }
    }
}
