//
//  DetailsViewController.swift
//  FlickrViewer
//
//  Created by Roshan Abraham on 3/3/2023.
//

import UIKit

final class DetailsViewController: UIViewController {
    
    private var viewModel: DetailsViewModel?
    
    let imageView = UIImageView()
    let titleLabel = FVLabel(fontSize: .heading)
    let idLabel = FVLabel(fontSize: .subheading)
    let tagLabel = FVLabel(fontSize: .body)
    let closeButton = FVCloseButton()
    
    private var widthMult = 0.8
    

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .systemBackground
        viewModel?.assignData(vc: self)
        
        configureScrollView()
        configureCloseButton()
        configureImageView()
        configureLabels()
    }
    
    private func configureScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    
    private func configureCloseButton() {
        contentView.addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            closeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            closeButton.heightAnchor.constraint(equalToConstant: 20),
            closeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20)
        ])
    }
    
    private func configureImageView() {
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 30),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9)
        ])
    }
    
    private func configureLabels() {
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4)
        ])
        
        contentView.addSubview(idLabel)
        NSLayoutConstraint.activate([
            idLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            idLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 200),
            idLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4),
        ])
        
        contentView.addSubview(tagLabel)
        NSLayoutConstraint.activate([
            tagLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            tagLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 200),
            tagLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4),
            tagLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    @objc func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
}
