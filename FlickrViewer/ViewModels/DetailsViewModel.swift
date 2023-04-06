//
//  DetailsViewModel.swift
//  FlickrViewer
//
//  Created by Roshan Abraham on 4/4/2023.
//

import UIKit

final class DetailsViewModel {
    
    private var data: Photo?
    private var img: UIImage?
    
    private let defaultText: String = "Loading..."
    
    init(data: Photo? = nil, img: UIImage? = nil) {
        self.data = data
        self.img = img
    }
    
    // public func that assigns the details VC with the data in the vm
    public func assignData(vc: DetailsViewController) {
        vc.imageView.image = self.img
        vc.titleLabel.setText(text: "Title: \(self.data?.title ?? defaultText)")
        vc.idLabel.setText(text: "ID: \(self.data?.id ?? defaultText)")
        vc.tagLabel.setText(text: "Tags: \(self.data?.tags ?? defaultText)")
        
    }
    
}
