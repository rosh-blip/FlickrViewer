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

        // check if the initial data load has been completed, i wish there was a way to just know this
            // then check if cell.imageview.image = nil
        
        if(cell.imageView.image == nil || cell.imageView.image == UIImage(systemName: "gear")){
            if((server != nil) && (id != nil) && (secret != nil)){
                if(viewModel.imageDict[id!] == nil){
                    viewModel.requestImg(server: server!, id: id!, secret: secret!)
                }
//                not too sure about use of main q here
//                DispatchQueue.main.async {
                    cell.updateImage(img: self.viewModel.imageDict[id!] ?? UIImage(systemName: "gear")!)
//                }
            }
        }
        
//        if(viewModel.imageDict[id] == UIImage(systemName: "gear")!) {
//        }
//        cell.updateImage(img: viewModel.currImg!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = viewModel.metaData?.photos.photo[indexPath.row].id
        
        let data = viewModel.metaData?.photos.photo[indexPath.row] ?? dummyPhotoData
        let img = viewModel.imageDict[id!]
        let detailsVC = DetailsViewController(data: data, img: img)
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
