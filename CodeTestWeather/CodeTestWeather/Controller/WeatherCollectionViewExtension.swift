//
//  WeatherCollectionViewExtension.swift
//  CodeTestWeather
//
//  Created by Ricky on 17/7/2021.
//

import Foundation
import Nuke

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.bounds.width
        let cellHeight = weatherCellHeight

        return CGSize(width: cellWidth, height: cellHeight)
    }
}

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherViewModel.weather.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        let data = weatherViewModel.weather[indexPath.row]
        cell.cityName.text = data.name
        cell.temperature.text = "Temperature: \(data.main?.temp.stringValue ?? "")"
        cell.weatherDesc.text = data.weather.first?.weatherDescription
        cell.humidity.text = "Humidity: \((data.main?.humidity) ?? 0)%"
        if let url = URL(string: data.weather.first?.iconStringURL ?? "")  {
            Nuke.loadImage(
                with: url,
                into: cell.weatherImage
            )
        }
        
        return cell
    }
    
    
}
