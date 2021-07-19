//
//  MockUpWeather.swift
//  CodeTestWeatherTests
//
//  Created by Ricky on 19/7/2021.
//

import Foundation


struct MockWeather {
    var viewModel: Weather!
    static var data: [Weather] {
        let weather1 = Weather()
        weather1.name = "HongKong1"
        weather1.weather.last?.weatherDescription = "few clouds"
        weather1.main?.temp = 308.17
        weather1.weather.last?.icon = "02d"
        weather1.main?.humidity = 5
        
        let weather2 = Weather()
        weather2.name = "HongKong2"
        weather2.weather.last?.weatherDescription = "few clouds"
        weather2.main?.temp = 308.17
        weather2.weather.last?.icon = "02d"
        weather2.main?.humidity = 5
        
        let weather3 = Weather()
        weather3.name = "HongKong3"
        weather3.weather.last?.weatherDescription = "few clouds"
        weather3.main?.temp = 308.17
        weather3.weather.last?.icon = "02d"
        weather3.main?.humidity = 5
        
        return [weather1, weather2, weather3]
    }
}
