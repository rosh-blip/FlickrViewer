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
    
    var locationService = LocationService()
    var networkService = NetworkService()
    
    let num = 100
    var metaData: Flickr?
    var imageDict: [String: UIImage] = [:] // instead of creating a dictionary i could just add a new field to metaData
    
    
    public let defaultText: String = "Loading..."
    
    public func initHomeViewModel(delegate: HomeViewModelDelegate) {
        self.delegate = delegate
        locationService.initLocationService(delegate: self)
        networkService.initNetworkService(delegate: self)
    }
    
    
    public func requestLocation() {
        locationService.getUserLocation()
    }
    
    
    private func requestMetaData(location: CLLocation) {
        let url = networkService.formatMetaDataRequest(location: location, num: num)
        
        networkService.fetchMetaData(from: url) { [weak self] success, data in
            guard let self = self else { return }
            if success {
                guard let data = data else { return }
                self.metaData = data
                self.delegate?.didUpdateImgList()
            } else {
                print("Metadata Network Request failed")
            }
        }
    }
    
    func requestImage(of id: String, from url: URL){
        networkService.fetchImage(of: id, from: url)
    }
    
    func getData(at position: Int) -> Photo? {
        return metaData?.photos.photo[position]
    }
    
     func getId(at position: Int) -> String {
        return metaData?.photos.photo[position].id ?? defaultText
    }
    
    func getServer(at position: Int) -> String {
        return metaData?.photos.photo[position].server ?? defaultText
    }
    
    func getSecret(at position: Int) -> String {
        return metaData?.photos.photo[position].secret ?? defaultText
    }
    
    func getTitle(at position: Int) -> String {
        return metaData?.photos.photo[position].title ?? defaultText
    }
    
    func getTags(at position: Int) -> String {
        return metaData?.photos.photo[position].tags ?? defaultText
    }
    
    func getURL(at position: Int) -> URL {
        return metaData?.photos.photo[position].url ?? URL(string: defaultText)!
    }
}



extension HomeViewModel: LocationServiceDelegate {
    func didGetLocation(location: CLLocation) {
        requestMetaData(location: location)
    }
}


extension HomeViewModel: NetworkServiceDelegate {
    func didGetImg(image: UIImage, id: String) {
        imageDict[id] = image
        self.delegate?.didUpdateImgs()
    }
}
