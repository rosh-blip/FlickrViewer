//
//  DetailsViewController.swift
//  FlickrViewer
//
//  Created by Roshan Abraham on 3/3/2023.
//

import UIKit

// use separate vm for the details vc 
// use to assign the data from the prev vc

class DetailsViewController: UIViewController {
    
    private var viewModel: DetailsViewModel?
    
    public var imageView = UIImageView()
    public var titleLabel = FVLabel(fontSize: .heading)
    public var idLabel = FVLabel(fontSize: .subheading)
    public var tagLabel = FVLabel(fontSize: .body)
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // use a different ui lifecycle to improve performance
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        viewModel?.assignData(vc: self) // might want to move this to the init
        configureImageView()
        configureLabels()
        
    }
    
    // set some constants to improve readability ie width = 0.8 or defaultImg = UIImage(smth)
    private func configureImageView(){
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
//        imageView.image = self.img ?? UIImage(systemName: "bolt.circle") // replace with img url

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20)
        ])
    }
    
    
    private func configureLabels(){
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
