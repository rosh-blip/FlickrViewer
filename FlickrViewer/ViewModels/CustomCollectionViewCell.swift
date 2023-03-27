//
//  CollectionViewCell.swift
//  FlickrViewer
//
//  Created by Roshan Abraham on 3/3/2023.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomCollectionViewCell"
    private let networkService = NetworkService()
    
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "bolt.circle")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemRed
        contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)
    }
    
//    func updateImage(){
////        self.imageView =
//    }
}
