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
    let baseURL: String = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=84943cbdaddb93e5aaa7f1bc856facbe&extras=tags&per_page=30&page=1&format=json&nojsoncallback=1"
    var imgList: Flickr?
    
    func requestLocation() {
        locationService.initLocationService(delegate: self)
    }
    
    func formatImageListRequest(location: CLLocation) -> URL {
        let lat: String = String(location.coordinate.latitude)
        let long: String = String(location.coordinate.longitude)
        let url = self.baseURL + "&lat=" + lat + "&lon=" + long
        //print(url) // success -> getting correct url
        return URL(string: url)!
    }
    
    func requestImageList(location: CLLocation) {
        let url = formatImageListRequest(location: location)
        networkService.getImgList(from: url, delegate: self)
        
        
    }
    
}

extension ViewModel: LocationServiceDelegate {
    func didGetLocation(location: CLLocation) {
        requestImageList(location: location)
        
    }
}
extension ViewModel: NetworkServiceDelegate {
    func didGetImgList(imgList: Flickr) {
        print(imgList)
        self.imgList = imgList
    }
}
