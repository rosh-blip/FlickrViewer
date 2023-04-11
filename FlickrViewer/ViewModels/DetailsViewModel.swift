//
//  DetailsViewModel.swift
//  FlickrViewer
//
//  Created by Roshan Abraham on 4/4/2023.
//

import UIKit

final class DetailsViewModel {
    
    private var title: String?
    private var tags: String?
    private var id: String?
    private var img: UIImage?
    
    private let defaultText: String = "Loading..."
    
    init(id: String? = nil, title: String? = nil, tags: String? = nil, img: UIImage? = nil) {
        self.id = id
        self.title = title
        self.tags = tags
        self.img = img
    }
    
    // public func that assigns the details VC with the data in the vm
    public func assignData(vc: DetailsViewController) {
        vc.imageView.image = self.img
        vc.titleLabel.setText(text: "Title: \(self.title ?? defaultText)")
        vc.idLabel.setText(text: "ID: \(self.id ?? defaultText)")
        vc.tagLabel.setText(text: "Tags: \(self.tags ?? defaultText)")
        
    }
    
}
