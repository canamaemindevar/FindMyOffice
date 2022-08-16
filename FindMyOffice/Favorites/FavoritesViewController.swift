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

final class FavoritesViewController: UIViewController {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var interactor: FavoritesBusinessLogic?
    var router: (FavoritesRoutingLogic & FavoritesDataPassing)?
    
    var names = [String]()
    var rooms = [String]()
    var capacity = [String]()
    var image = [String]()
    var id = [String]()
    var adress = [String]()
    var fav = [Bool]()
    
    
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
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as? OfficeListCell else { return UITableViewCell()}
        cell.nameLabel.text = names[indexPath.row]
        cell.roomsLabel.text = rooms[indexPath.row]
        cell.officeView.sd_setImage(with: URL(string: image[indexPath.row] ))
        
        return cell
        }
    
    
    
}
extension FavoritesViewController{
    func retrieveValues(){
                  if let appDelegate = UIApplication.shared.delegate as?AppDelegate{
                      let context = appDelegate.persistentContainer.viewContext
                      let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"OfficeModel")
                      fetchRequest.returnsObjectsAsFaults = false
    
                     do{
                         let results = try context.fetch(fetchRequest)
    
                         for result in results as! [NSManagedObject]{
                             if let name = result.value(forKey: "name") as? String{
                                 self.names.append(name)
                             }
                             if let room = result.value(forKey: "rooms") as? String{
                                 self.rooms.append(room)
                             }
                             if let image = result.value(forKey: "image") as? String{
                                 self.image.append(image)
                             }
                             if let id = result.value(forKey: "id") as? String{
                                 self.id.append(id)
                             }
                             if let capacity = result.value(forKey: "capacity") as? String{
                                 self.capacity.append(capacity)
                             }
                             if let adress = result.value(forKey: "adress") as? String{
                                 self.adress.append(adress)
                             }
                             if let fav = result.value(forKey: "fav") as? Bool{
                                 self.fav.append(fav)
                             }
                             self.tableView.reloadData()
                             
                         }
                     }catch {
                         print("Could not retrieve")
                     }
                  }
              }
}
/*
 let storyboard = UIStoryboard(name: "FullScreen", bundle: nil)
 let destinationVC: FullScreenViewController = storyboard.instantiateViewController(withIdentifier: "FullScreen") as! FullScreenViewController
 destinationVC.router?.dataStore?.officeElement = dataStore?.officeElement
 
 destinationVC.router?.dataStore?.selectedImageIndex = index
 destinationVC.delegate = viewController
 self.viewController?.navigationController?.pushViewController(destinationVC, animated: true)
 */
