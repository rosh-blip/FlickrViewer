//
//  HomeViewModel.swift
//  FlickrViewer
//
//  Created by Roshan Abraham on 10/3/2023.
//

import CoreLocation
import UIKit


protocol HomeViewModelDelegate: AnyObject {
    func didUpdateImgList()
    func didUpdateImgs()
}

//clear up: what vc is view model is this for
// lock up the funcs that don't need to be externally accessed
final class HomeViewModel {

    weak var delegate: HomeViewModelDelegate?
    
    private var locationService = LocationService()
    private var networkService = NetworkService()
    let num = 100

    static var metaData: Flickr?
    static var imageDict: [String: UIImage] = [:]
    
    
    public func initHomeViewModel(delegate: HomeViewModelDelegate) {
        self.delegate = delegate
        locationService.initLocationService(delegate: self)
        networkService.initNetworkService(delegate: self)
    }
    
    public func requestLocation() {
        locationService.getUserLocation()
    }
    
    
    // this should live in NS
    private func formatImageListRequest(location: CLLocation) -> URL {
        let lat: String = String(location.coordinate.latitude)
        let long: String = String(location.coordinate.longitude)
        return URL(string: "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=84943cbdaddb93e5aaa7f1bc856facbe&extras=tags&per_page=\(num)&page=1&format=json&nojsoncallback=1&lat=\(lat)&lon=\(long)")!
    }
    
    
    private func requestImageList(location: CLLocation) { // use completion handler rather than delegate here
        let url = formatImageListRequest(location: location)
        networkService.getImgList(from: url)
    }
    
    // should live in NS
    private func formatImgRequest(server: String, id: String, secret: String) -> URL {
        return URL(string: "https://live.staticflickr.com/\(server)/\(id)_\(secret)_s.jpg")!
    }
    
    public func requestImg(server: String, id: String, secret: String) {
        //  need to implement a check if the image is already in the dictionary
        // might be able to do this in the vc
        let url = formatImgRequest(server: server, id: id, secret: secret)
        networkService.getImg(from: url, id: id)
    }
}

extension HomeViewModel: LocationServiceDelegate {
    func didGetLocation(location: CLLocation) {
        requestImageList(location: location)
        
    }
}
extension HomeViewModel: NetworkServiceDelegate {
    func didGetImg(image: UIImage, id: String) {
    
        HomeViewModel.imageDict[id] = image
        self.delegate?.didUpdateImgs()
        
    }
    
    func didGetImgList(imgList: Flickr) {
        HomeViewModel.metaData = imgList
        self.delegate?.didUpdateImgList()
    }
}
