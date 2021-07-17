//
//  DetailViewController.swift
//  CodeTestWeather
//
//  Created by Ricky on 17/7/2021.
//

import Foundation
import UIKit

class DetailViewController: UIViewController{
    
    @IBOutlet weak var selectedCountryLabel: UILabel? // temp test for pused data
    
    var selectedCountry: String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedCountryLabel?.text = selectedCountry
    }
}
