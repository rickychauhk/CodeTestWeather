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

    let weatherViewModel: WeatherViewModel = WeatherViewModel()
    var searchedCity: String? = ""
    var lat: String? = ""
    var lon: String? = ""
    @IBOutlet var collectionView: UICollectionView!
    let detailViewModel: DetailViewModel = DetailViewModel()
    let weatherCellHeight: CGFloat = 160.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
    }

    func setupCollectionView(){
        collectionView = detailViewModel.setupCollectionView(collectionView: collectionView)
        weatherViewModel.getCachedWeatherData()
        getDataFromAPI()
    }
    
    //MARK: Fetch Data
    func getDataFromAPI(){
        self.showLoader(animated: true)
        weatherViewModel.getWeatherData(city: self.searchedCity, lat: self.lat, lon: self.lon)
        getFetchedDataHandle()
    }
    
    
    func getFetchedDataHandle(){
        weatherViewModel.dataLoadIsSuccess = { [weak self] in
            self!.collectionView.reloadData()
            self!.hideLoader()
        }
        
        weatherViewModel.dataLoadFailure = { [weak self] in
            self!.hideLoader()
            let controller = UIAlertController(title: "", message: Constants.alertMessage, preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                self?.navigationController?.popViewController(animated: true)
                self?.dismiss(animated: true, completion: nil)
            }))
            self!.present(controller, animated: true, completion: nil)
        }
    }
    
    func hideLoader() {
        self.hideLoader(animated: true)
    }
}
