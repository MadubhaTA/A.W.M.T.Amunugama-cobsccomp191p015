//
//  UIStoryboard+Extensions.swift
//  A.W.M.T.Amunugama-cobsccomp191p015
//
//

import UIKit

extension UIStoryboard {
    
    static func loginStoryboard() -> (UIStoryboard) {
        return UIStoryboard.init(name: "Login", bundle: Bundle.main)
    }
    
    static func mainStoryboard() -> (UIStoryboard) {
        return UIStoryboard.init(name: "Main", bundle: Bundle.main)
    }
}
