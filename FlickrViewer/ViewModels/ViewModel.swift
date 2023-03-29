//
//  HomeViewModel.swift
//  FlickrViewer
//
//  Created by Roshan Abraham on 10/3/2023.
//

import CoreLocation
import UIKit


final class ViewModel {

    private var locationService = LocationService()
    private var networkService = NetworkService() 
    let baseURL: String = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=84943cbdaddb93e5aaa7f1bc856facbe&extras=tags&per_page=30&page=1&format=json&nojsoncallback=1"
    var imgList: Flickr?
    var imgs = Array<UIImage>(repeating: UIImage(systemName: "gear")!, count: 30)
    
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
    
    
    func formatImgRequest(server: String, id: String, secret: String) -> URL {
        return URL(string: "https://live.staticflickr.com/\(server)/\(id)_\(secret)_s.jpg")!
    }

    func requestImg(server: String, id: String, secret: String, pos: Int) {
        
        let url = formatImgRequest(server: server, id: id, secret: secret)
        networkService.getImg(from: url, delegate: self, pos: pos)
    }
}

extension ViewModel: LocationServiceDelegate {
    func didGetLocation(location: CLLocation) {
        requestImageList(location: location)
        
    }
}
extension ViewModel: NetworkServiceDelegate {
    func didGetImg(image: UIImage, pos: Int) {
        self.imgs.insert(image, at: pos)
    }
    
    func didGetImgList(imgList: Flickr) {
        self.imgList = imgList
        // here lets just load all the images in 1
    }
}
