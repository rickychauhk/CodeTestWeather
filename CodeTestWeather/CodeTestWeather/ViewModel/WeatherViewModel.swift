//
//  WeatherViewModel.swift
//  CodeTestWeather
//
//  Created by Ricky on 17/7/2021.
//

import Foundation

class WeatherViewModel {
    
    var weather: [Weather] = []
    
    var dataLoadIsSuccess: (() -> Void)? = nil
    var dataLoadFailure: (() -> Void)? = nil

    func getWeatherData(city: String?, lat: String?, lon: String?){
        let request = WeatherRequest(city: city ?? "", latitude: lat ?? "", longitude: lon ?? "")
        APIManager.shared().request(type: request) { [weak self] (result: ResultResponse<Weather>)  in
            
            switch result{
            case .success(let data):
                self?.weather.append(data)
                self?.saveWeatherObjectToReakmDb(weather: data)
                self?.dataLoadIsSuccess?()
                
            case .failure(let error):
                self?.dataLoadFailure?()
                debugPrint(error?.errorMessage ?? "Error fetching data")
            }
        }
    }
    
    //MARK: Realm Data
    func getCachedWeatherData(){
        if let data = RealmManager.shared.getAllOperation(ofType: Weather.self){
            let weatherDataArray = Array(data) as! [Weather]
            if !weatherDataArray.isEmpty{
                weather = weatherDataArray
                dataLoadIsSuccess?()
            }
        }
    }
    
    func saveWeatherObjectToReakmDb(weather: Weather){
        RealmManager.shared.writeOperation(objectOfType: weather)
    }
}
