//
//  FVCloseButton.swift
//  FlickrViewer
//
//  Created by Roshan Abraham on 13/4/2023.
//

import UIKit

class FVCloseButton: UIButton {

    override init(frame: CGRect){
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        setTitleColor(.systemBlue, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        setTitle("Done", for: .normal)
        
    }
}
