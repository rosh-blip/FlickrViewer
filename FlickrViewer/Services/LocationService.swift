//
//  LocationService.swift
//  FlickrViewer
//
//  Created by Roshan Abraham on 23/3/2023.
//

import UIKit
import CoreLocation

protocol LocationServiceDelegate: AnyObject {
    func didGetLocation(location: CLLocation)
}

class LocationService: NSObject {
    
    weak var delegate: LocationServiceDelegate?
    var manager = CLLocationManager()
    
    func initLocationService(delegate: LocationServiceDelegate?) {
        self.delegate = delegate
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
}

// test that the view model can be loaded first

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            manager.stopUpdatingLocation()

            delegate?.didGetLocation(location: location)
        }
    }
}
