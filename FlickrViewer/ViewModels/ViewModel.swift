//
//  HomeViewModel.swift
//  FlickrViewer
//
//  Created by Roshan Abraham on 10/3/2023.
//

import CoreLocation
import UIKit


protocol ViewModelDelegate: AnyObject {
    func didUpdateImgList() // needs to be called and defined
    func didUpdateImgs() // needs to be called and defined
}

final class ViewModel {

    weak var delegate: ViewModelDelegate?
    
    private var locationService = LocationService()
    private var networkService = NetworkService() // can pass the delegate in here, don't need to pass in delegate each func call

    var imgList: Flickr?
    var imgs = Array<UIImage>(repeating: UIImage(systemName: "gear")!, count: 30)
    
    
    func initViewModel(delegate: ViewModelDelegate) {// will eventually require a delegate from the view controller
        self.delegate = delegate
        locationService.initLocationService(delegate: self)
        networkService.initNetworkService(delegate: self)
    }
    
    func requestLocation() {
        locationService.getUserLocation()
    }
    
    
    
    func formatImageListRequest(location: CLLocation) -> URL {
        let lat: String = String(location.coordinate.latitude)
        let long: String = String(location.coordinate.longitude)
        return URL(string: "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=84943cbdaddb93e5aaa7f1bc856facbe&extras=tags&per_page=30&page=1&format=json&nojsoncallback=1&lat=\(lat)&lon=\(long)")!
    }
    
    func requestImageList(location: CLLocation) {
        let url = formatImageListRequest(location: location)
        networkService.getImgList(from: url)
    }
    
    
    func formatImgRequest(server: String, id: String, secret: String) -> URL {
        return URL(string: "https://live.staticflickr.com/\(server)/\(id)_\(secret)_s.jpg")!
    }

    func requestImg(server: String, id: String, secret: String, pos: Int) {
        
        let url = formatImgRequest(server: server, id: id, secret: secret)
        networkService.getImg(from: url, pos: pos)
    }
}

extension ViewModel: LocationServiceDelegate {
    func didGetLocation(location: CLLocation) {
        requestImageList(location: location)
        
    }
}
extension ViewModel: NetworkServiceDelegate {
    func didGetImg(image: UIImage, pos: Int) {
        self.imgs.insert(image, at: pos) // this does not reload the collecview
        self.delegate?.didUpdateImgs()
    }
    
    func didGetImgList(imgList: Flickr) {
        self.imgList = imgList
        self.delegate?.didUpdateImgList()
        // need to notify the collec view so it can start loading in images correctly
    }
}
