//
//  Utilities.swift
//  A.W.M.T.Amunugama-cobsccomp191p015
//
//

import UIKit
import SKToast
import Alamofire
import MBProgressHUD
import AlamofireObjectMapper
import ObjectMapper

class Utilities: NSObject {
    
    class func isLoggedIn() -> Bool {
        if (Utilities.token().elementsEqual("")) {
            return false
        } else {
            return true
        }
    }
    
    class func errorToast(error: String) {
         SKToast.show(withMessage: error)
        SKToast.messageTextColor(UIColor.red)
        
    }
    
    class func messageToast(message: String) {
            SKToast.show(withMessage: message)
        SKToast.messageTextColor(.white)
       }
    
    class func showLoader() {
        MBProgressHUD.showAdded(to: ((UIApplication.shared.keyWindow)!), animated: true)
    }
    
    class func hideLoader() {
        MBProgressHUD.hide(for: ((UIApplication.shared.keyWindow)!), animated: true)
    }
    
    class func saveToken(token: String) {
           UserDefaults.standard.set(token, forKey: "token")
       }
       
       class func token() -> String {
           if let token = UserDefaults.standard.string(forKey: "token") {
               return token
           } else {
               return ""
           }
       }
    
    class func saveName(name: String) {
              UserDefaults.standard.set(name, forKey: "name")
          }
          
          class func name() -> String {
              if let name = UserDefaults.standard.string(forKey: "name") {
                  return name
              } else {
                  return ""
              }
          }
    
    

}
