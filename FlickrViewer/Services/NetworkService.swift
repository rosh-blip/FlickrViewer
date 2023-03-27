//
//  NetworkService.swift
//  FlickrViewer
//
//  Created by Roshan Abraham on 27/3/2023.
//

import Foundation
import UIKit

protocol NetworkServiceDelegate: AnyObject {
    func didGetImgList(imgList: Flickr)
    func didGetImg(image: UIImage)
//    func getImageDetails(int)
}

final class NetworkService {
    
    weak var delegate: NetworkServiceDelegate?
    
    func getImgList(from url: URL, delegate: NetworkServiceDelegate) {
        self.delegate = delegate
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
            delegate.didGetImgList(imgList: json)
        })
        
        task.resume()
    }
    
    func getImg(from url: URL, delegate: NetworkServiceDelegate){
        self.delegate = delegate
        
        
        DispatchQueue.global().async {
            // Fetch Image Data
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    // Create Image and Update Image View
//                    self.imageView.image = UIImage(data: data)
                    
                    delegate.didGetImg(image: (UIImage(data:data) ?? UIImage(systemName: "gear")!))
                }
            }
        }
        
    }
}
