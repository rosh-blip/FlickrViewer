//
//  ImageListVC.swift
//  FlickrViewer
//
//  Created by Roshan Abraham on 28/2/2023.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private var collectionView: UICollectionView?
    private var viewModel = ViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.requestLocation()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: (view.frame.size.width/3) - 4,
                                 height: (view.frame.size.height/5) - 7)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else { return }
        
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        
    }

    
    // grid
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath)
        // i reckon i can use indexPath here to dynamically allocate images to squares,
//        let title = viewModel.imgList?.photos.photo[indexPath.row].title ?? "loading"
//        print(title)
        
        
        
        let server = viewModel.imgList?.photos.photo[indexPath.row].server
        let id = viewModel.imgList?.photos.photo[indexPath.row].id
        let secret = viewModel.imgList?.photos.photo[indexPath.row].secret
        
        // could do without all this checking if instead i did the error checking in the dataTask
        if ((server != nil) && (id != nil) && (secret != nil)) {
            let url: URL = viewModel.formatLoadImgRequest(server: server!, id: id!, secret: secret!)
            viewModel.loadImg(from: url)
            
            print(url)
        }
        
//        print(title!)
        // the cv after some time is able to notice the changes in the vm, and reinstates itself automatically
        // now we need to update the imageview
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = viewModel.imgList?.photos.photo[indexPath.row] ?? dummyPhotoData
        let detailsVC = DetailsViewController(photo: photo) // passing through a struct
//        detailsVC.photo = photo
        present(detailsVC, animated: true)
        
        
    }
}
