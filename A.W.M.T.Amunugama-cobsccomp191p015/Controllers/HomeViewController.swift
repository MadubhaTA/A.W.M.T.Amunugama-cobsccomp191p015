//
//  HomeViewController.swift
//  A.W.M.T.Amunugama-cobsccomp191p015
//
//

import UIKit
import MapKit
import CoreLocation

class Annotation: NSObject, MKAnnotation
{
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    var custom_image: Bool = true
    var color: MKPinAnnotationColor = MKPinAnnotationColor.purple
}


class HomeViewController: UIViewController, CLLocationManagerDelegate,MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var temps = [TempAllResponse]()
    var highTemps = [TempAllResponse]()
    var curntCod:CLLocation?
    var curntLoc:CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        if let coor = mapView.userLocation.location?.coordinate{
            mapView.setCenter(coor, animated: true)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Utilities.showLoader()
        APIClient.shared.getAllTemp { (status, response) in
            Utilities.hideLoader()
            if (status == APIClient.APIResponseStatus.Success) {
                self.temps = response!
                if self.temps.count > 0 {
                    for temp in self.temps {
                        if let tempar = temp.temp {
                            if let value = tempar.temparature {
                                if let latv = tempar.lat {
                                    let lati:Double = Double(latv) ?? 0.0
                                    if let lonv = tempar.long {
                                        let longi:Double = Double(lonv) ?? 0.0
                                        if Double(value)! > 38.055 {
                                            let point = CLLocation(latitude: lati, longitude: longi)
                                            
                                            let distanceInMeters = self.curntCod!.distance(from: point)
                                            if distanceInMeters < 2000 {
                                                DispatchQueue.main.async {
                                                    self.addAnnotation(name: tempar.name!, temp: value, loc:CLLocationCoordinate2DMake(lati, longi))
//                                                    self.addAnnotation(name: "test", temp: "test", loc: self.curntLoc!)
//                                                    self.addAnnotation(name: tempar.name!, temp: value, loc:CLLocationCoordinate2DMake(6.9104648, 79.8928571))
                                                    print("added")
                                                }
                                                
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        curntCod = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
        curntLoc = locValue
        
        mapView.mapType = MKMapType.standard
        let range = 0.009 * 2 //2km
        let span = MKCoordinateSpan(latitudeDelta: range, longitudeDelta: range)
        let region = MKCoordinateRegion(center: locValue, span: span)
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
    }
    
    func addAnnotation(name:String, temp:String, loc:CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = loc
        annotation.title = name
        annotation.subtitle = temp
        mapView.addAnnotation(annotation)
        
    }
    
    @IBAction func didTapLogout(_ sender: Any) {
        Utilities.saveToken(token: "")
        let loginVc = UIStoryboard.loginStoryboard().instantiateViewController(identifier: "LoginVC") as? LoginViewController
        self.view.window?.rootViewController = loginVc
    }
}
