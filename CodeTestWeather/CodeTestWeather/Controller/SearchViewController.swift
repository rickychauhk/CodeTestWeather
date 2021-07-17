//
//  SearchViewController.swift
//  CodeTestWeather
//
//  Created by Ricky on 17/7/2021.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet var tableView: UITableView!
    
    var searchViewModel: SearchViewModel = SearchViewModel()
    var cityList = [String]()
    
    var searchedCity = [String]()
    var searching = false
    
    var selected: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView = searchViewModel.setupTableView(tableView: self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchBar.delegate = self
        
        self.searchBar = searchViewModel.setupSearchbar(searchBar: self.searchBar)
        
        self.listOfCountries()
    }
    
    func listOfCountries() {
      
            let userDefaults = UserDefaults.standard

            cityList = (userDefaults.object(forKey: Constants.storeKey) as? [String] ?? [])
//            dataFiltered = data
            tableView.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsviewcontrollerseg" {
            let detailViewController = segue.destination as? DetailViewController
            detailViewController?.selectedCountry = selected
        }
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
        // Remove highlight from the selected cell
        tableView.deselectRow(at: indexPath, animated: true)
        // Close keyboard when you select cell
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
            let detailViewController = DetailViewController()
            performSegue(withIdentifier: "detailsviewcontrollerseg", sender: self)
            detailViewController.selectedCountry = city
        }
    }
}
