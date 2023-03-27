//
//  NetworkService.swift
//  FlickrViewer
//
//  Created by Roshan Abraham on 23/3/2023.
//

import UIKit

class NetworkService: NSObject {
    
    func requestImageList(from url: URL, completion: @escaping (Flickr?, Error?) -> (Void) ){
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let data = data else {
                completion(nil, error)
                return
            }
            do {
                let response = try JSONDecoder().decode(Flickr.self, from: data)
                completion(response, nil)
            } catch let error {
                completion(nil, error)
            }
        }
        task.resume()
    }
    

}
extension NetworkService: URLSessionDelegate {
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        let downloadTask = session.downloadTask(with: url)
        downloadTask.resume()
    }
    


}
//
//extension NetworkService: URLSessionDownloadDelegate {
//
//}
