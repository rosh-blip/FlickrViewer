//
//  SpinnerViewController.swift
//  FlickrViewer
//
//  Created by Roshan Abraham on 18/4/2023.
//

import UIKit

class SpinnerCell: UICollectionViewCell {
    
    static let identifier = "SpinnerCell"
    
    var spinner : UIActivityIndicatorView = {
            let view = UIActivityIndicatorView()
            view.style = .large
            return view
        }()
        override init(frame: CGRect) {
            super.init(frame: frame)
            setup()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setup()
        }
        
        func setup(){
            contentView.addSubview(spinner)
            spinner.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                spinner.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                spinner.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
            spinner.startAnimating()
        }
        

}
