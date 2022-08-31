//
//  FavoritesViewController.swift
//  FindMyOffice
//
//  Created by Emincan on 15.08.2022.
//

import UIKit
import CoreData
import SDWebImage

protocol FavoritesDisplayLogic: AnyObject {
    
}

final class FavoritesViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    var interactor:( FavoritesBusinessLogic & CoreDataFav )?
    var router: (FavoritesRoutingLogic & FavoritesDataPassing )?
    
    var viewModelForFav: [Favorites.Case.ViewModel.ModelForCoreData] = []
    
    
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
        tableView.register(UINib(nibName: "OfficeListCell", bundle: nil), forCellReuseIdentifier: "MyCell")
        retrieveValues()
        
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = FavoritesInteractor()
        let presenter = FavoritesPresenter()
        let router = FavoritesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}

extension FavoritesViewController: FavoritesDisplayLogic {
    
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModelForFav.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as? OfficeListCell
        else { return UITableViewCell()}
        
        
        cell.favButton.isHidden = true
        cell.nameLabel.text = viewModelForFav[indexPath.row].name
        cell.roomsLabel.text = viewModelForFav[indexPath.row].rooms
        cell.officeView.sd_setImage(with: URL(string: viewModelForFav[indexPath.row].image ?? ""))
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            
            CoreDataManager().deleteCoreData(with:Int(viewModelForFav[indexPath.row].id ?? 99))
            
            viewModelForFav.remove(at: indexPath.row)
            
            
            self.tableView.reloadData()
        }
    }
    

    
    
    func retrieveValues(){
        
        interactor?.coreDataGetFunc { result in
            self.viewModelForFav = result
        }
    }
}

