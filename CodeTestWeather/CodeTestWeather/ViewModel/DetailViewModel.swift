//
//  DetailViewModel.swift
//  CodeTestWeather
//
//  Created by Ricky on 17/7/2021.
//

import Foundation
import UIKit


class DetailViewModel: NSObject, UICollectionViewDelegate{
    
    
    func setupCollectionView(collectionView: UICollectionView) -> UICollectionView {
        
        collectionView.alwaysBounceVertical = true
        return collectionView
    }
    
   
    
    func textEncode(text: String) -> String{
        let searchText = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        return searchText!
    }
}

