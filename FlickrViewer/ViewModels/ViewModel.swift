//
//  HomeViewModel.swift
//  FlickrViewer
//
//  Created by Roshan Abraham on 10/3/2023.
//

import CoreLocation
import UIKit


protocol ViewModelDelegate: AnyObject {
    func didUpdateImgList()
    func didUpdateImgs()
}

//clear up: what vc is view model is this for
// lock up the funcs that don't need to be externally accessed
final class ViewModel {

    weak var delegate: ViewModelDelegate?
    
    private var locationService = LocationService()
    private var networkService = NetworkService()
    let num = 100

    var metaData: Flickr?
    var imageDict: [String: UIImage] = [:]
    
    
    func initViewModel(delegate: ViewModelDelegate) {
        self.delegate = delegate
        locationService.initLocationService(delegate: self)
        networkService.initNetworkService(delegate: self)
    }
    
    func requestLocation() {
        locationService.getUserLocation()
    }
    
    
    // this should live in NS
    func formatImageListRequest(location: CLLocation) -> URL {
        let lat: String = String(location.coordinate.latitude)
        let long: String = String(location.coordinate.longitude)
        return URL(string: "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=84943cbdaddb93e5aaa7f1bc856facbe&extras=tags&per_page=\(num)&page=1&format=json&nojsoncallback=1&lat=\(lat)&lon=\(long)")!
    }
    
    
    func requestImageList(location: CLLocation) { // use completion handler rather than delegate here
        let url = formatImageListRequest(location: location)
        networkService.getImgList(from: url)
    }
    
    // should live in NS
    func formatImgRequest(server: String, id: String, secret: String) -> URL {
        return URL(string: "https://live.staticflickr.com/\(server)/\(id)_\(secret)_s.jpg")!
    }
    
    func requestImg(server: String, id: String, secret: String) {
        //  need to implement a check if the image is already in the dictionary
        // might be able to do this in the vc
        let url = formatImgRequest(server: server, id: id, secret: secret)
        networkService.getImg(from: url, id: id)
    }
}

extension ViewModel: LocationServiceDelegate {
    func didGetLocation(location: CLLocation) {
        requestImageList(location: location)
        
    }
}
extension ViewModel: NetworkServiceDelegate {
    func didGetImg(image: UIImage, id: String) {
    
        self.imageDict[id] = image
        self.delegate?.didUpdateImgs()
        
    }
    
    func didGetImgList(imgList: Flickr) {
        self.metaData = imgList
        self.delegate?.didUpdateImgList()
    }
}
