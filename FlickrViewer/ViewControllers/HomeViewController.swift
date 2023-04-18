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
    override func loadView() {
        super.loadView()
        view.backgroundColor = .systemBackground
        configureCollectionView()
    }
    
    override func viewDidLoad() {
        viewModel.initHomeViewModel(delegate: self)
        viewModel.requestLocation()
    }
    
    private func configureCollectionView() {
        let layout = configureCollectionViewLayout()
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
       
        configureCollectionViewBounds(collectionView: collectionView)
    }
    
    private func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 6
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize (width: (view.frame.size.width/3) - 4,
                                  height: (view.frame.size.height/5) - 7)
        return layout
        
    }
    
    private func configureCollectionViewBounds(collectionView: UICollectionView){
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

 
extension HomeViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.num
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        
        let id = viewModel.getId(at: indexPath.row)
        let url = viewModel.getURL(at:indexPath.row)
        let cellImage = cell.imageView.image
        
        if(cellImage == nil || cellImage == UIImage(systemName: "gear")){
            if(id != viewModel.defaultText) {
                if(viewModel.imageDict[id] == nil){
                    viewModel.requestImage(of: id, from: url)
                }
            }
                // have a placeholder intially instead of
                // UIActivityIndicatorView loading spinner (sort of) can use for a splash screen
            cell.updateImage(img: viewModel.imageDict[id] ?? UIImage(systemName: "gear")!)
//            }
        }
        
        return cell
    }
}


extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let id = viewModel.getId(at: indexPath.row)
        let image = viewModel.imageDict[id]
        
        let detailsVM = DetailsViewModel(data: viewModel.getData(at: indexPath.row), image: image)
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
