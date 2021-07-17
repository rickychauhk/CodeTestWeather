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
        
        tableView.separatorStyle = .none
        tableView.tintColor = .white
        tableView.backgroundColor = .white
        
        return tableView
    }
    
    func setupSearchbar(searchBar: UISearchBar) -> UISearchBar {
        
        searchBar.barTintColor = .systemGray2
        searchBar.tintColor = .white
    
        searchBar.showsCancelButton = true
        return searchBar
    }
    
    func setupNumberOfRowsInSection(searching:Bool, section:Int, cityList:[String], searchedCity:[String]) -> Int{
        var dataCount = 0
        if searching {
            dataCount = searchedCity.count
        } else {
            dataCount = cityList.count
        }
        
        return dataCount
    }
    
    func setupCellForRowAt(searching: Bool, tableView: UITableView, indexPath: IndexPath, cityList:[String], searchedCity:[String]) -> UITableViewCell{
        let cell = UITableViewCell()
      
        if searching {
            cell.textLabel?.text = searchedCity[indexPath.row]
        } else {
            cell.textLabel?.text = cityList[indexPath.row]
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
        updateCityList(cityList: cities)
        return tableView
    }
    
    func updateCityList(cityList: [String]){
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(cityList, forKey: Constants.storeKey)
    }
    
    func textEncode(text: String) -> String{
        let searchText = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        return searchText!
    }
    
}
