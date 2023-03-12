//
//  HomeViewModel.swift
//  FlickrViewer
//
//  Created by Roshan Abraham on 10/3/2023.
//

import UIKit
import CoreLocation

class HomeViewModel: NSObject, CLLocationManagerDelegate {
    // what does the view model need to do?
        // get user location
        // make api call
    let baseURL = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=84943cbdaddb93e5aaa7f1bc856facbe&extras=tags&per_page=30&page=1&format=json&nojsoncallback=1"
    
    var lat: CLLocationDegrees?
    var long: CLLocationDegrees?
    
    var locManager = CLLocationManager()
    
    func getCoords(){
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.delegate = self
        locManager.requestWhenInUseAuthorization()
        locManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            manager.stopUpdatingLocation()
            
            self.lat = location.coordinate.latitude
            self.long = location.coordinate.longitude
        }
    }
    
    func requestFlickr(){
        // must be run AFTER getCoords
            // need to account for this by unwrapping the conditional
        // pass data to the api manager
        
    }
}
