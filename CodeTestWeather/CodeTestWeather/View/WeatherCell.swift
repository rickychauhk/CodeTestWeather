//
//  WeatherCell.swift
//  CodeTestWeather
//
//  Created by Ricky on 17/7/2021.
//

import UIKit

class WeatherCell: UICollectionViewCell {
    
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherDesc: UILabel!
    @IBOutlet weak var cityName: UILabel!
    
    override func awakeFromNib() {
        
    }
}

