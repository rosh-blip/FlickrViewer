//
//  ImageListVC.swift
//  FlickrViewer
//
//  Created by Roshan Abraham on 28/2/2023.
//

import UIKit


class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private var collectionView: UICollectionView?
    private var viewModel = ViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.initViewModel(delegate: self)
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
        
        collectionView.reloadData()
    }

    
    // grid
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        collectionView.reloadData()
        return viewModel.num
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        
        let server = viewModel.metaData?.photos.photo[indexPath.row].server
        let id = viewModel.metaData?.photos.photo[indexPath.row].id
        let secret = viewModel.metaData?.photos.photo[indexPath.row].secret

        if(viewModel.imgs[indexPath.row] == UIImage(systemName: "gear")!) {
            if((server != nil) && (id != nil) && (secret != nil)){
                viewModel.requestImg(server: server!, id: id!, secret: secret!, pos: indexPath.row)
            }
        }
        cell.updateImage(img: viewModel.imgs[indexPath.row])
//        cell.updateImage(img: viewModel.currImg!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let data = viewModel.metaData?.photos.photo[indexPath.row] ?? dummyPhotoData
        let img = viewModel.imgs[indexPath.row]
        let detailsVC = DetailsViewController(data: data, img: img) // passing through a struct
        present(detailsVC, animated: true)
        
        
    }
}
 
extension HomeViewController: ViewModelDelegate {
    func didUpdateImgs() {
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
        
    }
    
    func didUpdateImgList() {
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
}
