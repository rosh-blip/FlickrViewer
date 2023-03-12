//
//  FVLabel.swift
//  FlickrViewer
//
//  Created by Roshan Abraham on 3/3/2023.
//

import UIKit

class FVLabel: UILabel {
    
    public enum textSize {
        case heading
        case subheading
        case body
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(text: String, fontSize: textSize){ // make an enum for heading, subheading, body
        super.init(frame: .zero)
        self.text = text
        switch fontSize{
        case .heading:
            self.font = .systemFont(ofSize: 28)
        case .subheading:
            self.font = .systemFont(ofSize: 17)
        case .body:
            self.font = .systemFont(ofSize: 13)
        }
        configure()
        
    }
    
    func configure() {
        textColor = .label
        textAlignment = .left
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
    

}
