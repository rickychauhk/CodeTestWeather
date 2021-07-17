//
//  DetailViewModel.swift
//  CodeTestWeather
//
//  Created by Ricky on 17/7/2021.
//

import Foundation
import UIKit
import DropDown

protocol SearchControllerDelegate: AnyObject{
    func searchBarDidBeginEditing()
    func reloadData(city: String)
}

class DetailViewModel: NSObject, UISearchBarDelegate, UICollectionViewDelegate{
    
    weak var delegate: SearchControllerDelegate?
    var data: [String] = []
    var dataFiltered: [String] = []
    let dropButton = DropDown()
    let weatherViewModel: WeatherViewModel = WeatherViewModel()
    
    func setupCollectionView(collectionView: UICollectionView) -> UICollectionView {
        
        collectionView.alwaysBounceVertical = true
        return collectionView
    }
    
    func setup(searchBar: UISearchBar) {
        searchBar.delegate = self
        dropButton.anchorView = searchBar
        dropButton.bottomOffset = CGPoint(x: 0, y:(dropButton.anchorView?.plainView.bounds.height)!)
        dropButton.backgroundColor = .white
        dropButton.direction = .bottom
        
        dropButton.selectionAction = { [unowned self] (index: Int, item: String) in
            debugPrint("Selected item: \(item) at index: \(index)") //Selected item: code at index: 0
            searchBar.text = item
            delegate?.reloadData(city: textEncode(text: item))
        }
        let userDefaults = UserDefaults.standard

        data = (userDefaults.object(forKey: Constants.storeKey) as? [String] ?? [])
        dataFiltered = data
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        delegate?.searchBarDidBeginEditing()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        dropButton.hide()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        dataFiltered = searchText.isEmpty ? data : data.filter({ (dat) -> Bool in
            dat.range(of: searchText, options: .caseInsensitive) != nil
        })
        
        dropButton.dataSource = dataFiltered
        dropButton.show()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !Constants.isNilOrEmpty(string: searchBar.text) {
            weatherViewModel.weather.removeAll()
            delegate?.reloadData(city: textEncode(text: searchBar.text!))
            insetCity(searchText: textEncode(text: searchBar.text!))
        }
    }
    
    func insetCity(searchText: String){

        var isExists = false
        for dataItem in data {
            if dataItem == searchText{
                isExists = true
                return
            }
        }
        
        if !isExists || data.count == 0 {
            let decodedString = searchText.removingPercentEncoding!
            data.append(decodedString)
            let userDefaults = UserDefaults.standard
            userDefaults.set(data, forKey: Constants.storeKey)
        }
    }
    
    func textEncode(text: String) -> String{
        let searchText = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        return searchText!
    }
}

