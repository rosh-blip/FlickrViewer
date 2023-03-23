//
//  HomeViewModel.swift
//  FlickrViewer
//
//  Created by Roshan Abraham on 10/3/2023.
//

import Foundation
import CoreLocation


final class ViewModel {
    
    private var locationService = LocationService()
    private var networkService = NetworkService()
    var imageList: Flickr = dummyFlickrData
    
    let baseURL: String = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=84943cbdaddb93e5aaa7f1bc856facbe&extras=tags&per_page=30&page=1&format=json&nojsoncallback=1"
    
    var reqURL: URL?
    
    func requestLocation() {
        locationService.initLocationService(delegate: self)
    }
    
    func formatImageListRequest(location: CLLocation) -> URL {
        let lat: String = String(location.coordinate.latitude)
        let long: String = String(location.coordinate.longitude)
        let url = self.baseURL + "&lat=" + lat + "&lon=" + long
        print(url) // success -> getting correct url
        return URL(string: url)!
    }
    
    func requestImageList(location: CLLocation) {
        let url = formatImageListRequest(location: location)
//        self.imageList = networkService.requestImageList(from: url, completion: )
        networkService.requestImageList(from: url) { [weak self] imageList, error in
            if let error = error {
                print("error", error)
                return
            }
            
            guard let self = self,
                  let list = imageList else {
                return
            }
            
            self.imageList = list
            print(self.imageList)
//            print(self?.imageList!)
//            DispatchQueue.main.async {
//                HomeViewController.collectionView(self).reloadData()
//            }
            
        }
        // requestImageList -> return [Photo]
        // what to do with this? -> 
        
    }
    
}
    extension ViewModel: LocationServiceDelegate {
        func didGetLocation(location: CLLocation) {
            requestImageList(location: location)
            
        }
    }
