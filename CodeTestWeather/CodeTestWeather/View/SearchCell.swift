//
//  SearchCell.swift
//  CodeTestWeather
//
//  Created by Ricky on 17/7/2021.
//

import Foundation
import UIKit

class SearchCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel?
    var cityItem: String = ""
    
    override func awakeFromNib() {
    super.awakeFromNib()
//        titleLabel.text = cityItem
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
    }
    
}
