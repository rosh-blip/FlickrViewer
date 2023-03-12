//
//  FlickrDataModel.swift
//  FlickrViewer
//
//  Created by Roshan Abraham on 8/3/2023.
//

import Foundation

struct Flickr: Codable {
    let photos: PageStats
}

struct PageStats: Codable{
    let page: Int
    let pages: Int
    let perpage: Int
    let total: Int
    let photo: [Photo]
}

struct Photo: Codable {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    let ispublic: Int
    let isfriend: Int
    let isfamily: Int
    let tags: String
    
}
