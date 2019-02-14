//
//  ViewController.swift
//  Maps
//
//  Created by Allvy on 19/09/18.
//  Copyright © 2018 Allvy. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController,CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate=self
        manager.desiredAccuracy=kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        
        self.manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        self.manager.distanceFilter = 10
        // self.locationManager.desiredAccuracy = 15
        
        self.manager.requestAlwaysAuthorization()
        self.manager.allowsBackgroundLocationUpdates = true
        self.manager.pausesLocationUpdatesAutomatically = false
        self.manager.startUpdatingLocation()
        self.manager.startMonitoringSignificantLocationChanges()
        self.manager.delegate = self
        self.manager.allowDeferredLocationUpdates(untilTraveled: 10, timeout: 5)
        
        
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            print("New location is \(location)")
        }
        let location = locations[0]
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation:CLLocationCoordinate2D=CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion=MKCoordinateRegionMake(myLocation, span)
        map.setRegion(region, animated: true)
        self.map.showsUserLocation=true
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            // you're good to go!
        }
    }

}

