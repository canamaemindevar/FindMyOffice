//
//  OfficeDetailViewController.swift
//  FindMyOffice
//
//  Created by Emincan on 6.08.2022.
//

import UIKit

protocol OfficeDetailDisplayLogic: AnyObject {
    func displayOfficeDetail(viewModel: OfficeDetail.Fetch.ViewModel)
}

final class OfficeDetailViewController: UIViewController {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var roomsLabel: UILabel!
    @IBOutlet weak var capacityLabel: UILabel!
    @IBOutlet weak var spaceLabel: UILabel!
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var interactor: OfficeDetailBusinessLogic?
    var router: (OfficeDetailRoutingLogic & OfficeDetailDataPassing)?
    
    
    var viewModel: OfficeDetail.Fetch.ViewModel?
    let layout = UICollectionViewFlowLayout()
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    @IBAction func showWebsite(_ sender: UIButton) {
        router?.routeToWebSite()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = OfficeDetailInteractor()
        let presenter = OfficeDetailPresenter()
        let router = OfficeDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    
    func setUpForCollection(){
        self.collectionView.register(UINib(nibName: "OfficeImagesCell", bundle: .main), forCellWithReuseIdentifier: "OfficeImagesCell")
        
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 15
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        let image = UIImage(systemName: "rectangle.grid.2x2.fill")
        let button = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(tapped))
        navigationItem.rightBarButtonItem = button
        
    }
    
    override func viewDidLoad()  {
        super.viewDidLoad()
        interactor?.fetchOfficeDetail(request: OfficeDetail.Fetch.Request())
        setUpForCollection()
    }
    
    
}


// MARK: collectionView
extension OfficeDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { // değiştir
        print(section)
        return viewModel?.images?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //değiştir
     guard  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OfficeImagesCell", for: indexPath) as? OfficeImagesCell
        else {
         return UICollectionViewCell()}
        
        guard let model = viewModel else {
            return UICollectionViewCell()
        }
        cell.configure(images: model.images?[indexPath.row] ?? "")
        
        return cell 
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router?.routeToFullScreen(index: indexPath.row)
    }
    
    
    @objc func tapped(){
        if layout.scrollDirection == .horizontal {
            layout.scrollDirection = .vertical
        } else {
            layout.scrollDirection = .horizontal
        }
        collectionView.reloadData()
    }
    
    
//    func getIndex(indexPath: IndexPath){ // from fullscreen
//        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//    }
    
    
}

extension OfficeDetailViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1) // soldan sağdan... ne kadar boşluk istiyor
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let gridLayout = collectionViewLayout as? UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 2 - (gridLayout?.minimumInteritemSpacing ?? CGFloat())
        return CGSize(width: widthPerItem, height: 150)
    }
    
    
}


extension OfficeDetailViewController: OfficeDetailDisplayLogic , getIndexFromFull {
    func displayOfficeDetail(viewModel: OfficeDetail.Fetch.ViewModel) {
        self.viewModel = viewModel
        DispatchQueue.main.async {
            self.navigationItem.title = "\(viewModel.name!)"
     //       self.nameLabel.text =  "Name: \(viewModel.name!)"
            self.adressLabel.text = "Adress: \(viewModel.address!)"
            self.roomsLabel.text = "Rooms: \(viewModel.rooms!)"
            self.capacityLabel.text = "Capacity: \(viewModel.capacity!)"
            self.spaceLabel.text = "Space: \(viewModel.space!)"
            self.collectionView.reloadData()
            
            
        }
    }
    
    func   fullScreenIndexPath(indexPath: IndexPath){
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
    }
    
    
}

