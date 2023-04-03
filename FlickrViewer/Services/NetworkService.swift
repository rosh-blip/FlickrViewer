//
//  NetworkService.swift
//  FlickrViewer
//
//  Created by Roshan Abraham on 27/3/2023.
//

import UIKit

protocol NetworkServiceDelegate: AnyObject {
    func didGetImgList(imgList: Flickr)
    func didGetImg(image: UIImage, id: String)
//    func getImageDetails(int)
}

final class NetworkService {
    
    weak var delegate: NetworkServiceDelegate?
    
    func initNetworkService(delegate: NetworkServiceDelegate){
        self.delegate = delegate
    }
    
    func getImgList(from url: URL) {
//        print(url)
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
    
    
    func getImg(from url: URL, id: String){
        
        
        DispatchQueue.global().async {
            // Fetch Image Data
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    // Create Image and Update Image View
//                    self.imageView.image = UIImage(data: data)
                    
//                    self.delegate!.didGetImg(image: (UIImage(data:data) ?? UIImage(systemName: "gear")!), pos: pos)
                    
                    
                    
                    // here im going to add send the image back via delegate
                    // in the delegate im going to add the image to a cache
                    self.delegate?.didGetImg(image: UIImage(data: data)!, id: id)
                }
            }
        }
        
    }
}
