//
//  Loader.swift
//  CodeTestWeather
//
//  Created by Ricky on 17/7/2021.
//

import Foundation
import MBProgressHUD

class Loader {
    
    static func showAdded(to view: UIView, animated: Bool){
        DispatchQueue.main.async {
            let hud = MBProgressHUD.showAdded(to: view, animated: animated)
            if hud != nil
            {
                hud?.mode = .indeterminate
                hud?.removeFromSuperViewOnHide = true
                hud?.isUserInteractionEnabled = false
                hud?.hide(true, afterDelay: 10)
            }
        }
    }
    
    static func hide(for view: UIView, animated: Bool){
        MBProgressHUD.hide(for: view, animated: animated)
    }
    
}

extension UIViewController {
    
    func showLoader(animated: Bool = false) {
        Loader.showAdded(to: self.view, animated: animated)
    }
    
    func hideLoader(animated: Bool = false) {
        Loader.hide(for: self.view, animated: animated)
    }
}
