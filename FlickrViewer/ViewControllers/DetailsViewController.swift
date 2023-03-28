//
//  DetailsViewController.swift
//  FlickrViewer
//
//  Created by Roshan Abraham on 3/3/2023.
//

import UIKit

class DetailsViewController: UIViewController {
    var data: Photo?
    var img: UIImage?
    
    var imageView = UIImageView()
    var titleLabel = FVLabel(text: "dummy", fontSize: .heading)
    var idLabel = FVLabel(text: "dummy", fontSize: .subheading)
    var tagLabel = FVLabel(text: "dummy", fontSize: .body)
    
    
    init(data: Photo? = nil, img: UIImage?) {
        self.data = data
        self.img = img
        self.titleLabel.text = self.data?.title ?? "loading"
        self.idLabel.text = self.data?.id ?? "loading"
        self.tagLabel.text = self.data?.tags ?? "loading"
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureImageView()
        configureLabels()
    }
    
    
    func configureImageView(){
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = self.img ?? UIImage(systemName: "bolt.circle") // replace with img url

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20)
        ])
    }
    
    
    func configureLabels(){
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)

        ])
        view.addSubview(idLabel)
        NSLayoutConstraint.activate([
            idLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            idLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            idLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)

        ])
        
        view.addSubview(tagLabel)
        NSLayoutConstraint.activate([
            tagLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tagLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 20),
            tagLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
        
    }
    
}
