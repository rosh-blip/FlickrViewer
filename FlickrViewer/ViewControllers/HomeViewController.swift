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
        
        
        let server = viewModel.getServer(at: indexPath.row)
        let id = viewModel.getId(at: indexPath.row)
        let secret = viewModel.getSecret(at: indexPath.row)
        
        if(cell.imageView.image == nil || cell.imageView.image == UIImage(systemName: "gear")){
            // could avoid all of this if instead just adding the url as a field in the model immediately
            if((server != viewModel.defaultText) && (id != viewModel.defaultText) && (secret != viewModel.defaultText)){
                if(HomeViewModel.imageDict[id] == nil){
                    viewModel.requestImg(server: server, id: id, secret: secret)
                }
                // have a placeholder intially instead of
                // UIActivityIndicatorView loading spinner (sort of) can use for a splash screen
                cell.updateImage(img: HomeViewModel.imageDict[id] ?? UIImage(systemName: "gear")!)
            }
        }
        
        return cell
    }
}


extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let id = viewModel.getId(at: indexPath.row)
        let title = viewModel.getTitle(at: indexPath.row)
        let tags = viewModel.getTags(at: indexPath.row)
        let img = HomeViewModel.imageDict[id]
        
        let detailsVM = DetailsViewModel(id: id, title: title, tags: tags, img: img)
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
