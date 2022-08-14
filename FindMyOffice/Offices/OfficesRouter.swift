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


final class OfficesRouter: OfficesRoutingLogic, OfficesDataPassing {
    func routeToOfficeDetail(index: Int) {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC: OfficeDetailViewController = storyboard.instantiateViewController(withIdentifier: "OfficeDetail") as! OfficeDetailViewController
        destinationVC.router?.dataStore?.officeElement = dataStore?.officeData?[index]
        
       self.viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    
    weak var viewController: OfficesViewController?
    var dataStore: OfficesDataStore?
    
}


// MARK: filter

