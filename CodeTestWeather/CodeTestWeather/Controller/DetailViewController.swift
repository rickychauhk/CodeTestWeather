//
//  DetailViewController.swift
//  CodeTestWeather
//
//  Created by Ricky on 17/7/2021.
//

import Foundation
import UIKit


class DetailViewController: UIViewController{
    
    @IBOutlet weak var selectedCountryLabel: UILabel? // temp test for pused data
    
    let weatherViewModel: WeatherViewModel = WeatherViewModel()
    var selectedCountry: String? = ""
    var lat: String? = ""
    var lon: String? = ""
    let searchWeatherModel: SearchWeatherModel = SearchWeatherModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedCountryLabel?.text = selectedCountry

        getDataFromAPI()
    }
    
    func getDataFromAPI(){
        
        weatherViewModel.weather.removeAll()
        weatherViewModel.getWeatherData(city: selectedCountry ?? "", lat: lat ?? "", lon: lon ?? "")
    }
}
