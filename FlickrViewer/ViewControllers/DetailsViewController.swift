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
    
    var imageView = UIImageView()
    var titleLabel = FVLabel(fontSize: .heading)
    var idLabel = FVLabel(fontSize: .subheading)
    var tagLabel = FVLabel(fontSize: .body)
    var closeButton = FVCloseButton()
    
    private var widthMult = 0.8
    
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
        viewModel?.assignData(vc: self)
        
        configureCloseButton()
        configureImageView()
        configureLabels()
        
    }
    
    // set some constants to improve readability ie width = 0.8 or defaultImg = UIImage(smth)
    
    
    
    private func configureCloseButton() {
        view.addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.heightAnchor.constraint(equalToConstant: 20),
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20)
            
        ])
    }
    
    
    private func configureImageView(){
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: widthMult),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 40)
        ])
    }
    
    
    private func configureLabels(){
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: widthMult)

        ])
        view.addSubview(idLabel)
        NSLayoutConstraint.activate([
            idLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            idLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            idLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: widthMult)

        ])
        
        view.addSubview(tagLabel)
        NSLayoutConstraint.activate([
            tagLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tagLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 20),
            tagLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: widthMult)
        ])
        
    }
    

    
    @objc func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
}
