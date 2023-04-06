//
//  NetworkService.swift
//  FlickrViewer
//
//  Created by Roshan Abraham on 27/3/2023.
//

import UIKit
import CoreLocation

protocol NetworkServiceDelegate: AnyObject {
    func didGetImgList(imgList: Flickr)
    func didGetImg(image: UIImage, id: String)
}

final class NetworkService {
    
    weak var delegate: NetworkServiceDelegate?
    
    public func initNetworkService(delegate: NetworkServiceDelegate){
        self.delegate = delegate
    }
    
    public func getImgList(from url: URL) {
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                print("failed to retrieve")
                return
            }
            var result: Flickr?
            do {
                result = try JSONDecoder().decode(Flickr.self, from: data)
            }
            catch {
                print("failed to convert")
            }
            guard let json = result else {
                return
            }
            DispatchQueue.main.async {
                self.delegate!.didGetImgList(imgList: json)
            }
        })
        
        task.resume()
    }
    
    
    public func getImg(from url: URL, id: String){
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.delegate?.didGetImg(image: UIImage(data: data)!, id: id)
                }
            }
        }
        
    }
    
    public func formatImageListRequest(location: CLLocation, num: Int) -> URL {
        let lat: String = String(location.coordinate.latitude)
        let long: String = String(location.coordinate.longitude)
        return URL(string: "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=84943cbdaddb93e5aaa7f1bc856facbe&extras=tags&per_page=\(num)&page=1&format=json&nojsoncallback=1&lat=\(lat)&lon=\(long)")!
    }
    
    public func formatImgRequest(server: String, id: String, secret: String) -> URL {
        return URL(string: "https://live.staticflickr.com/\(server)/\(id)_\(secret)_s.jpg")!
    }
}
