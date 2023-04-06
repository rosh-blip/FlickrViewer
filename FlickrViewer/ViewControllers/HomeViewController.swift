//
//  ImageListVC.swift
//  FlickrViewer
//
//  Created by Roshan Abraham on 28/2/2023.
//

import UIKit

// have a splash screen
// better default image

class HomeViewController: UIViewController {
    
    private var collectionView: UICollectionView?
    private var viewModel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.initHomeViewModel(delegate: self)
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
}

 
extension HomeViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.num
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        
        let server = HomeViewModel.metaData?.photos.photo[indexPath.row].server
        let id = HomeViewModel.metaData?.photos.photo[indexPath.row].id
        let secret = HomeViewModel.metaData?.photos.photo[indexPath.row].secret
        
        if(cell.imageView.image == nil || cell.imageView.image == UIImage(systemName: "gear")){
            if((server != nil) && (id != nil) && (secret != nil)){
                if(HomeViewModel.imageDict[id!] == nil){
                    viewModel.requestImg(server: server!, id: id!, secret: secret!)
                }
                // have a placeholder intially instead of
                // UIActivityIndicatorView loading spinner (sort of) can use for a splash screen
                cell.updateImage(img: HomeViewModel.imageDict[id!] ?? UIImage(systemName: "gear")!)
            }
        }
        
        return cell
    }
}


extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // create functions that pulls out the meta data and the image itself, instead of accesssing in the vc
        let id = HomeViewModel.metaData?.photos.photo[indexPath.row].id
        
        let data = HomeViewModel.metaData?.photos.photo[indexPath.row] ?? dummyPhotoData
        let img = HomeViewModel.imageDict[id!]
        let detailsVM = DetailsViewModel(data: data, img: img)
        let detailsVC = DetailsViewController(viewModel: detailsVM)
        present(detailsVC, animated: true)
    }
}

extension HomeViewController: HomeViewModelDelegate {
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
