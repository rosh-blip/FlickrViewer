//
//  CollectionViewCell.swift
//  FlickrViewer
//
//  Created by Roshan Abraham on 3/3/2023.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomCollectionViewCell"
//    private let networkService = NetworkService()
    private let viewModel = ViewModel()
    
    
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
    
    public func updateImg(server: String?, id: String?, secret: String?){
        if((server != nil) && (id != nil) && (secret != nil)) { viewModel.requestImg(server: server!, id: id!, secret: secret!, delegate: self) }
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        imageView.image = nil
//    }
}



extension CustomCollectionViewCell: NetworkServiceDelegate {
    func didGetImgList(imgList: Flickr) {
    }
    
    func didGetImg(image: UIImage) {
        self.imageView.image = image
    }
}
