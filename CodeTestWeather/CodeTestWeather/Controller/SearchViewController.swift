//
//  SearchViewController.swift
//  CodeTestWeather
//
//  Created by Ricky on 17/7/2021.
//

import Foundation
import UIKit
import MapKit

class SearchViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var gpsBarBtn: UIBarButtonItem!
    
    let searchViewModel: SearchViewModel = SearchViewModel()
    let weatherViewModel: WeatherViewModel = WeatherViewModel()
    let searchWeatherModel: SearchWeatherModel = SearchWeatherModel()
    var cityList = [String]()
    var searchedCity = [String]()
    var searching = false
    var selected: String?
    
    var locationManger: CLLocationManager!
    var currentlocation: CLLocation?
    var lat: String = ""
    var lon: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView = searchViewModel.setupTableView(tableView: self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchBar.delegate = self
        
        self.searchBar = searchViewModel.setupSearchbar(searchBar: self.searchBar)
        
        self.listOfCountries()
    }
    
    @IBAction func getUserLLocation() {
        if (CLLocationManager.locationServicesEnabled()) {
            locationManger = CLLocationManager()
            locationManger.delegate = self
            locationManger.desiredAccuracy = kCLLocationAccuracyBest
            locationManger.requestWhenInUseAuthorization()
            locationManger.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.currentlocation = location
            
            let latitude: Double = self.currentlocation!.coordinate.latitude
            let longitude: Double = self.currentlocation!.coordinate.longitude
            
            self.lon = String(longitude)
            self.lat = String(latitude)
            searchWeatherModel.lat = String(latitude)
            searchWeatherModel.lon = String(longitude)
            
            if !Constants.isNilOrEmpty(string: self.lon) && !Constants.isNilOrEmpty(string: self.lat){
                performSegue(withIdentifier: "detailsviewcontrollerseg", sender: self)
                resetData()
            }
        }
    }
    
    func listOfCountries() {
        
        let userDefaults = UserDefaults.standard
        cityList = (userDefaults.object(forKey: Constants.storeKey) as? [String] ?? [])
        tableView.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsviewcontrollerseg" {
            let detailViewController = segue.destination as? DetailViewController
            detailViewController?.selectedCountry = selected
            detailViewController?.lat = self.lat
            detailViewController?.lon = self.lon
        }
    }
    
    func resetData() {
        self.searchBar.searchTextField.endEditing(true)
        self.lon = ""
        self.lat = ""
        self.selected = ""
        self.searching = false
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchViewModel.setupNumberOfRowsInSection(searching: searching, section: section, cityList: cityList, searchedCity: searchedCity)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
        }
    func tableView(_ tableView: UITableView, commit editingStyle:   UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if (editingStyle == .delete) {
                cityList.remove(at: indexPath.row)
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .middle)
                tableView.endUpdates()
                searchViewModel.updateCityList(cityList: cityList)
            }
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = searchViewModel.setupCellForRowAt(searching: searching, tableView: tableView, indexPath: indexPath, cityList: cityList, searchedCity: searchedCity)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searching {
            let selectedCountry = searchedCity[indexPath.row]
            selected = selectedCountry
        } else {
            let selectedCountry = cityList[indexPath.row]
            selected = selectedCountry
        }
        
        performSegue(withIdentifier: "detailsviewcontrollerseg", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
        self.searchBar.searchTextField.endEditing(true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedCity = cityList.filter { $0.lowercased().prefix(searchText.count) == searchText.lowercased() }
        searching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
//        let decodedString = "Japan".removingPercentEncoding!
//        cityList.append(decodedString)
//        searchViewModel.updateCityList(cityList: cityList)
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let city = searchBar.text {
            selected = city
            performSegue(withIdentifier: "detailsviewcontrollerseg", sender: self)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint(error.localizedDescription)
    }
}
