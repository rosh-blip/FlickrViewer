//
//  DetailsViewController.swift
//  FlickrViewer
//
//  Created by Roshan Abraham on 3/3/2023.
//

import UIKit

final class DetailsViewController: UIViewController {
    
    private var viewModel: DetailsViewModel?
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let navBar:  UINavigationBar = {
        let nav = UINavigationBar(frame: .zero)
        nav.backgroundColor = .systemGray
        return nav
    }()
    
    let imageView = UIImageView()
    let titleLabel = FVLabel(fontSize: .heading)
    let idLabel = FVLabel(fontSize: .subheading)
    let tagLabel = FVLabel(fontSize: .body)
    let closeButton = FVCloseButton()
    
    private let textWidth = 0.75
    private let imageWidth = 0.9
    private let spacing: CGFloat = 30
    
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
        
        configureDetailsUI()
    }
    
    private func configureDetailsUI(){
        configureNavBar()
        configureScrollView()
        configureImageView()
        configureLabels()
        view.bringSubviewToFront(navBar)
    }
    
    private func configureNavBar() {

        let doneButton: UIBarButtonItem = {
            let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(closeButtonTapped))
            return button
        }()
        
        
        let navItem: UINavigationItem = {
            let item = UINavigationItem()
            item.title = "Details"
            item.rightBarButtonItem = doneButton
            return item
        }()
        
        navBar.items = [navItem]
        
        navBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(navBar)
        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBar.widthAnchor.constraint(equalTo: view.widthAnchor),
            navBar.heightAnchor.constraint(equalToConstant: 44)
        ])
        
    }
    
    private func configureScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: navBar.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    private func configureImageView() {
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: spacing),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: imageWidth)
        ])
    }
    
    private func configureLabels() {
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: spacing),
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: textWidth)
        ])
        
        contentView.addSubview(idLabel)
        NSLayoutConstraint.activate([
            idLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            idLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: spacing),
            idLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: textWidth),
        ])
        
        contentView.addSubview(tagLabel)
        NSLayoutConstraint.activate([
            tagLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            tagLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: spacing),
            tagLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: textWidth),
            tagLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
}
