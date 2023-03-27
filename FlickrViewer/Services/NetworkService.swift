//
//  NetworkService.swift
//  FlickrViewer
//
//  Created by Roshan Abraham on 27/3/2023.
//

import Foundation

protocol NetworkServiceDelegate: AnyObject {
    func didGetImgList(imgList: Flickr)
//    func getImageDetails(int)
}

final class NetworkService {
    
    weak var delegate: NetworkServiceDelegate?
    
    func getImgList(from url: URL, delegate: NetworkServiceDelegate) {
        self.delegate = delegate
        print(url)
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            
            //            print(url)
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
            //            print (json.photos.photo[0].id)
            delegate.didGetImgList(imgList: json)
            // what if i create call the delegate function here, and pass the data out at this point?
            // could save the time of writing a new api service that uses the urlsession built-in delegate
            
        })
        
        task.resume()
        
    }
}
