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
    var cities = [String]()
    var searchedCities = [String]()
    var searching = false
    var selected: String = ""
    
    var locationManger: CLLocationManager!
    var lat: String = ""
    var lon: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView = searchViewModel.setupTableView(tableView: self.tableView)
        
        self.searchBar = searchViewModel.setupSearchbar(searchBar: self.searchBar)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        self.listOfCities()
        resetData()
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

            self.lon = String(location.coordinate.longitude)
            self.lat = String(location.coordinate.latitude)
            
            if !self.lon.isEmpty && !self.lat.isEmpty {
                performSegue(withIdentifier: Constants.detailViewId, sender: self)
                resetData()
            }
        }
    }
    
    func listOfCities() {
        
        let userDefaults = UserDefaults.standard
        self.cities = (userDefaults.object(forKey: Constants.storeKey) as? [String] ?? [])
        tableView.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.detailViewId {
            let detailViewController = segue.destination as? DetailViewController
            detailViewController?.searchedCity = self.selected as String
            detailViewController?.lat = self.lat as String
            detailViewController?.lon = self.lon as String
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint(error.localizedDescription)
    }
    
    func resetData() {
        self.searchBar.searchTextField.text = ""
        self.lon = ""
        self.lat = ""
        self.selected = ""
        self.searching = false
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchViewModel.setupNumberOfRowsInSection(searching: self.searching, section: section, cities: self.cities, searchedCity: self.searchedCities)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
        }
    func tableView(_ tableView: UITableView, commit editingStyle:   UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if (editingStyle == .delete) {
                self.cities.remove(at: indexPath.row)
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .middle)
                tableView.endUpdates()
                searchViewModel.updateCities(cities: cities)
            }
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = searchViewModel.setupCellForRowAt(searching: self.searching, tableView: tableView, indexPath: indexPath, cities: self.cities, searchedCity: self.searchedCities)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedCountry: String = ""
        if self.searching {
            selectedCountry = searchedCities[indexPath.row]
            selectedCountry = searchViewModel.textEncode(text: selectedCountry)
            
        } else {
            selectedCountry = cities[indexPath.row]
            selectedCountry = searchViewModel.textEncode(text: selectedCountry)
        }
        self.selected = selectedCountry
        performSegue(withIdentifier: Constants.detailViewId, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
        self.searchBar.searchTextField.endEditing(true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchedCities = cities.filter { $0.lowercased().prefix(searchText.count) == searchText.lowercased() }
        self.searching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searching = false
        searchBar.text = ""
        resetData()
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let city = searchBar.text {
            searchViewModel.insetCity(searchText: city, cities: self.cities)
            self.selected = searchViewModel.textEncode(text: city)
            performSegue(withIdentifier: Constants.detailViewId, sender: self)
            resetData()
        }
    }
}
