//
//  DetailViewController.swift
//  CodeTestWeather
//
//  Created by Ricky on 17/7/2021.
//

import Foundation
import UIKit
import Nuke

class DetailViewController: UIViewController{
    
    @IBOutlet weak var selectedCountryLabel: UILabel? // temp test for pused data
    
    let weatherViewModel: WeatherViewModel = WeatherViewModel()
    let weather: WeatherView = WeatherView()
    var selectedCountry: String? = ""
    var lat: String? = ""
    var lon: String? = ""
    let searchWeatherModel: SearchWeatherModel = SearchWeatherModel()
    @IBOutlet var collectionView: UICollectionView!
    let searchController: DetailViewModel = DetailViewModel()
    let weatherCellHeight: CGFloat = 160.0
    @IBOutlet var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedCountryLabel?.text = selectedCountry

        setupCollectionView()
        getDataFromAPI()
        weatherViewModel.dataLoadSuccessfully = { [weak self] in
            self!.collectionView.reloadData()
        }
    }
    
    //MARK: Fetch Data
    func getDataFromAPI(){
        
        weatherViewModel.weather.removeAll()
        weatherViewModel.getWeatherData(city: self.selectedCountry ?? "", lat: self.lat ?? "", lon: self.lon ?? "")
    }
    
    func setupCollectionView(){
        collectionView = searchController.setupCollectionView(collectionView: collectionView)
    }
}
