//
//  TemparatureViewController.swift
//  A.W.M.T.Amunugama-cobsccomp191p015
//
//

import UIKit
import CoreLocation

class TemparatureViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var txtTemp: UITextField!
    let locationManager = CLLocationManager()
    var lat = ""
    var long = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        lat = "\(locValue.latitude)"
        long = "\(locValue.longitude)"
    }
    
    
    @IBAction func didTapUpload(_ sender: Any) {
        var temp = self.txtTemp.text
        if (temp ?? "").isEmpty  {
            Utilities.errorToast(error: "Temparature is required!")
        } else {
            
            Utilities.showLoader()
            APIClient.shared.getUserTemp { (status, response) in
                Utilities.hideLoader()
                if (status == APIClient.APIResponseStatus.Success) {
                    Utilities.showLoader()
                    APIClient.shared.updateTemp(lat: self.lat, long: self.long, temp: temp!, name: Utilities.name()) { (status, response) in
                        Utilities.hideLoader()
                        if (status == APIClient.APIResponseStatus.Success) {
                            Utilities.messageToast(message: "Temparature updated succussfully")
                        } else {
                            Utilities.errorToast(error: "Temparature update failed")
                        }
                    }
                } else {
                    Utilities.showLoader()
                    APIClient.shared.createTemp(lat: self.lat, long: self.long, temp: temp!, name: Utilities.name()) { (status, response) in
                        Utilities.hideLoader()
                        if (status == APIClient.APIResponseStatus.Success) {
                            Utilities.messageToast(message: "Temparature updated succussfully")
                        } else {
                            Utilities.errorToast(error: "Temparature update failed")
                        }
                    }
                }
            }
            
        }
        
    }
    
    
    @IBAction func didTapLogout(_ sender: Any) {
        Utilities.saveToken(token: "")
        let loginVc = UIStoryboard.loginStoryboard().instantiateViewController(identifier: "LoginVC") as? LoginViewController
        self.view.window?.rootViewController = loginVc
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.txtTemp.resignFirstResponder()
        return true
    }
    
}
