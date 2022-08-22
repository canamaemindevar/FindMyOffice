//
//  OfficesRouter.swift
//  FindMyOffice
//
//  Created by Emincan on 4.08.2022.
//

import Foundation
import UIKit

protocol OfficesRoutingLogic: AnyObject {
    func routeToOfficeDetail(index: Int)
}

protocol OfficesDataPassing: AnyObject {
    var dataStore: OfficesDataStore? { get }
}
protocol GoToFavorites: AnyObject{
    func goToFav()
}
protocol GoToMapView: AnyObject{
    func routeToMapView()
}


final class OfficesRouter: OfficesRoutingLogic, OfficesDataPassing, GoToFavorites,GoToMapView {
 //   var newArray:[OfficeResponseElement] = []
    func routeToOfficeDetail(index: Int) {

        let storyboard = UIStoryboard(name: "OfficeDetail", bundle: nil)
        let destinationVC: OfficeDetailViewController = storyboard.instantiateViewController(withIdentifier: "OfficeDetail") as! OfficeDetailViewController
        destinationVC.router?.dataStore?.officeElement = dataStore?.officeData?[index]
        
       self.viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
    func goToFav(){
        let storyboard = UIStoryboard(name: "Favorites", bundle: nil)
        let destinationVC: FavoritesViewController = storyboard.instantiateViewController(withIdentifier: "FavoritesViewController") as! FavoritesViewController
        
        self.viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
    func routeToMapView(){
        let storyboard = UIStoryboard(name: "MapView", bundle: nil)
        let destinationVC: MapViewViewController = storyboard.instantiateViewController(withIdentifier: "MapViewViewController") as! MapViewViewController
      //  newArray = dataStore?.officeData ?? []
        guard let data = dataStore?.officeData else {
            print("problem here")
            return
            
        }
        destinationVC.router?.dataStore?.offices = data
        
    }
    
    
    
    weak var viewController: OfficesViewController?
    var dataStore: OfficesDataStore?
    
}


// MARK: filter

