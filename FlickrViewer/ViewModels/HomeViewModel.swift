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
    
    public let num = 100
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
    
    
    private func requestImageList(location: CLLocation) { // use completion handler rather than delegate here
        let url = networkService.formatImageListRequest(location: location, num: num)
        networkService.getImgList(from: url)
    }

    
    public func requestImg(server: String, id: String, secret: String) {
        let url = networkService.formatImgRequest(server: server, id: id, secret: secret)
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
