//
//  FullScreenViewController.swift
//  FindMyOffice
//
//  Created by Emincan on 8.08.2022.
//

import UIKit
import SDWebImage

protocol FullScreenDisplayLogic: AnyObject {
    func displayPics(viewModel:FullScreen.Fetch.ViewModel)
}

protocol getIndex: AnyObject{
    func fullScreenIndexPath(indexPath: IndexPath)
}


final class FullScreenViewController: UIViewController {
    
    @IBOutlet weak var fullScreenCollectionView: UICollectionView!
    
    var interactor: FullScreenBusinessLogic?
    var router: (FullScreenRoutingLogic & FullScreenDataPassing)?
    
    var viewModel: FullScreen.Fetch.ViewModel?
    weak var delegate: getIndex?
    
    
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fullScreenCollectionView.register(UINib(nibName: "fullScreenCell", bundle: .main), forCellWithReuseIdentifier: "fullScreenCell")
        interactor?.fetchOfficePics(request: OfficeDetail.Fetch.Request())
        setupCollection()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        fullScreenCollectionView.scrollToItem(at: IndexPath(row: viewModel?.selectedImageIndex ?? 0, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = FullScreenInteractor()
        let presenter = FullScreenPresenter()
        let router = FullScreenRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}

extension FullScreenViewController: FullScreenDisplayLogic {
    func displayPics(viewModel: FullScreen.Fetch.ViewModel) {
        self.viewModel = viewModel
        DispatchQueue.main.async {
            self.fullScreenCollectionView.reloadData()
        }
       
    }
}

extension FullScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.images.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = fullScreenCollectionView.dequeueReusableCell(withReuseIdentifier: "fullScreenCell", for: indexPath) as? fullScreenCell else {
            return UICollectionViewCell() }
        cell.config(images: viewModel?.images[indexPath.row])
    
            return cell
        }
    
    
    
    
}

extension FullScreenViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 1, left: 0, bottom: 1, right: 1) // soldan sağdan... ne kadar boşluk istiyor
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      //  let gridLayout = collectionViewLayout as? UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width  // - (gridLayout?.minimumInteritemSpacing ?? CGFloat())
        let heigthPerItem = collectionView.frame.height
        
        
        
        return CGSize(width: widthPerItem, height: heigthPerItem)
    }

    func setupCollection(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        fullScreenCollectionView.setCollectionViewLayout(layout, animated: true)
    }

}
