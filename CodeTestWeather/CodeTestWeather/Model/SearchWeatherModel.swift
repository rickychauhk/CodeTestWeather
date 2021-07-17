//
//  SearchWeatherModel.swift
//  CodeTestWeather
//
//  Created by Ricky on 17/7/2021.
//

import Foundation
import RealmSwift

class SearchWeatherModel: Object, Codable {

    @objc dynamic var lat: String?
    @objc dynamic var lon: String?
    @objc dynamic var city: String?

}
