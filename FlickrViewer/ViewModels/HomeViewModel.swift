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
    
    public enum metaDataField {
        case id
        case title
        case server
        case secret
        case tags
    }
    
    
    public let defaultText: String = "Loading..."
    
    public func initHomeViewModel(delegate: HomeViewModelDelegate) {
        self.delegate = delegate
        locationService.initLocationService(delegate: self)
        networkService.initNetworkService(delegate: self)
    }
    
    
    public func requestLocation() {
        locationService.getUserLocation()
    }
    
    
    private func requestImageList(location: CLLocation) {
        let url = networkService.formatImageListRequest(location: location, num: num)
        
        networkService.fetchMetaData(from: url) { success, data in
            if success {
                guard let data = data else { return }
                HomeViewModel.metaData = data
                self.delegate?.didUpdateImgList()
            } else {
                print("Metadata Network Request failed")
            }
        }
    }
    
    
    public func requestImg(server: String, id: String, secret: String) {
        let url = networkService.formatImgRequest(server: server, id: id, secret: secret)
        networkService.getImg(from: url, id: id)
    }
    
    public func getId(at position: Int) -> String {
        return HomeViewModel.metaData?.photos.photo[position].id ?? defaultText
    }
    
    public func getServer(at position: Int) -> String {
        return HomeViewModel.metaData?.photos.photo[position].server ?? defaultText
    }
    
    public func getSecret(at position: Int) -> String {
        return HomeViewModel.metaData?.photos.photo[position].secret ?? defaultText
    }
    
    public func getTitle(at position: Int) -> String {
        return HomeViewModel.metaData?.photos.photo[position].title ?? defaultText
    }
    
    public func getTags(at position: Int) -> String {
        return HomeViewModel.metaData?.photos.photo[position].tags ?? defaultText
    }
    
//    public func getMetaDataField(metaDataField: metaDataField, at position: Int){
//        var field: String?
//        switch metaDataField {
//        case .id:
//            field = "id"
//        case .title:
//            <#code#>
//        case .server:
//            <#code#>
//        case .secret:
//            <#code#>
//        case .tags:
//            <#code#>
//        }
//        return HomeViewModel.metaData?.photos.photo[position].field
//    }
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
}
