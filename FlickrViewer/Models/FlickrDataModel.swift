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
    let total: Int
    let photo: [Photo]
}

struct Photo: Codable {
    let id: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    let tags: String
    
}

let dummyPhotoData = Photo(id: "0", secret: "0", server: "0", farm: 0, title: "0", tags: "0")

let dummyPageStats = PageStats(total: 1, photo: [dummyPhotoData])

let dummyFlickrData: Flickr = Flickr(photos: dummyPageStats)

