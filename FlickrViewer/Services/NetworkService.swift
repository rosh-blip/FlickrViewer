//
//  NetworkService.swift
//  FlickrViewer
//
//  Created by Roshan Abraham on 27/3/2023.
//

import UIKit
import CoreLocation

protocol NetworkServiceDelegate: AnyObject {
    func didGetImg(image: UIImage, id: String)
}
// naming convention: all funcs making a request must begin with fetch
final class NetworkService {
    
    weak var delegate: NetworkServiceDelegate?
    
    public func initNetworkService(delegate: NetworkServiceDelegate){
        self.delegate = delegate
    }

    
    public func fetchMetaData(from url: URL, completion: @escaping (_ success: Bool, _ data: Flickr?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // should add a check for a good status code response
            if let data = data {
                guard let result = self.decodeMetaData(from: data) else { return }
                completion(true, result)
            }
            else {
                print("Could not retrieve data")
                completion(false, nil)
            }
        }
        task.resume()
    }
    

    public func fetchImage(of id: String, from url: URL) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.delegate?.didGetImg(image: UIImage(data: data)!, id: id)
                }
            }
        }
        
    }
    
    public func formatMetaDataRequest(location: CLLocation, num: Int) -> URL {
        let lat: String = String(location.coordinate.latitude)
        let long: String = String(location.coordinate.longitude)
        return URL(string: "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=84943cbdaddb93e5aaa7f1bc856facbe&extras=tags&per_page=\(num)&page=1&format=json&nojsoncallback=1&lat=\(lat)&lon=\(long)")!
    }
    
    
    private func decodeMetaData(from data: Data) -> Flickr? {
        var result: Flickr?
        do {
            result = try JSONDecoder().decode(Flickr.self, from: data)
            return result
        }
        catch { // TODO confirm how this works
            print("Could not convert data to expected Flickr Object")
            return nil
        }
    }
    
//    public func formatImgRequest(server: String, id: String, secret: String) -> URL {
//        return URL(string: "https://live.staticflickr.com/\(server)/\(id)_\(secret)_s.jpg")!
//    }
    
//    public func getImg(from url: URL, id: String){
//        DispatchQueue.global().async {
//            if let data = try? Data(contentsOf: url) {
//                DispatchQueue.main.async {
//                    self.delegate?.didGetImg(image: UIImage(data: data)!, id: id)
//                }
//            }
//        }
//    }
}
