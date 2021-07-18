//
//  SearchViewModel.swift
//  CodeTestWeather
//
//  Created by Ricky on 17/7/2021.
//

import Foundation
import UIKit


class SearchViewModel {
    
    func setupTableView(tableView: UITableView) -> UITableView {
        
        return tableView
    }
    
    func setupSearchbar(searchBar: UISearchBar) -> UISearchBar {
        
        searchBar.showsCancelButton = true
        return searchBar
    }
    
    func setupNumberOfRowsInSection(searching:Bool, section:Int, cities:[String], searchedCity:[String]) -> Int{
        var dataCount = 0
        if searching {
            dataCount = searchedCity.count
        } else {
            dataCount = cities.count
        }
        
        return dataCount
    }
    
    func setupCellForRowAt(searching: Bool, tableView: UITableView, indexPath: IndexPath, cities:[String], searchedCity:[String]) -> UITableViewCell{
        let cell = UITableViewCell()
      
        if searching {
            cell.textLabel?.text = searchedCity[indexPath.row]
        } else {
            cell.textLabel?.text = cities[indexPath.row]
        }
        
        return cell
    }
    
    func setupDidSelectRowAts(earching: Bool, tableView: UITableView, indexPath: IndexPath, cityList:[String], searchedCity:[String]){
        
    }
    
    func setupCanEditCommit(tableView: UITableView, indexPath: IndexPath, cityList: [String]) -> UITableView{
        var cities = cityList as [String]
        cities.remove(at: indexPath.row)
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .middle)
        tableView.endUpdates()
        updateCities(cities: cities)
        return tableView
    }
    
    func updateCities(cities: [String]){
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(cities, forKey: Constants.storeKey)
    }
    
    func textEncode(text: String) -> String{
        let searchText = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        return searchText!
    }
    
    func insetCity(searchText: String, cities: [String]){

        var isExists = false
        var cities = cities
        for city in cities {
            let decodedString = searchText.removingPercentEncoding!
            if city == decodedString{
                isExists = true
                return
            }
        }
        
        if !isExists || cities.count == 0 {
            let decodedString = searchText.removingPercentEncoding!
            cities.append(decodedString)
            updateCities(cities: cities)
        }
    }
}
