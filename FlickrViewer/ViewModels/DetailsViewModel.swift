//
//  DetailsViewModel.swift
//  FlickrViewer
//
//  Created by Roshan Abraham on 4/4/2023.
//

import UIKit

final class DetailsViewModel {
    
    let data: Photo?
    let image: UIImage?
    private let defaultText: String = "Loading..."
    
    init(data: Photo?, image: UIImage?) {
        self.data = data
        self.image = image
    }
    
    var id: String {
        data?.id ?? defaultText
    }
    var title: String {
        data?.title ?? defaultText
    }
    
    var tags: String {
        data?.tags ?? defaultText
    }
    
    // public func that assigns the details VC with the data in the vm
    func assignData(vc: DetailsViewController) {
        vc.imageView.image = self.image
        vc.titleLabel.setText(text: "Title: \(self.title)")
        vc.idLabel.setText(text: "ID: \(self.id)")
        vc.tagLabel.setText(text: "Tags: \(self.tags)")
        
    }
    
    
}
