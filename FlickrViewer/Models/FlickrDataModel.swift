//
//  FlickrDataModel.swift
//  FlickrViewer
//
//  Created by Roshan Abraham on 8/3/2023.
//

import Foundation

struct Flickr: Decodable {
    let photos: PageStats
}

struct PageStats: Decodable{
    let total: Int
    let photo: [Photo]
}

struct Photo: Decodable {
    let id: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    let tags: String
    let url: URL
    
    enum CodingKeys: CodingKey {
        case id
        case secret
        case server
        case farm
        case title
        case tags
        case url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.secret = try container.decode(String.self, forKey: .secret)
        self.server = try container.decode(String.self, forKey: .server)
        self.farm = try container.decode(Int.self, forKey: .farm)
        self.title = try container.decode(String.self, forKey: .title)
        self.tags = try container.decode(String.self, forKey: .tags)
        self.url = URL(string: "https://live.staticflickr.com/\(self.server)/\(self.id)_\(self.secret).jpg")!
    }
    
}

//let dummyPhotoData = Photo(id: "0", secret: "0", server: "0", farm: 0, title: "0", tags: "0")
//
//let dummyPageStats = PageStats(total: 1, photo: [dummyPhotoData])
//
//let dummyFlickrData: Flickr = Flickr(photos: dummyPageStats)
