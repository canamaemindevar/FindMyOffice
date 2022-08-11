//
//  OfficeDetailRouter.swift
//  FindMyOffice
//
//  Created by Emincan on 6.08.2022.
//

import Foundation
import UIKit

protocol OfficeDetailRoutingLogic: AnyObject {
    func routeToFullScreen(index: Int)
}

protocol OfficeDetailDataPassing: AnyObject {
    var dataStore: OfficeDetailDataStore? { get }
}

final class OfficeDetailRouter: OfficeDetailRoutingLogic, OfficeDetailDataPassing {
    func routeToFullScreen(index: Int) {
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let destinationVC: FullScreenViewController = storyboard.instantiateViewController(withIdentifier: "FullScreen") as! FullScreenViewController
        let storyboard = UIStoryboard(name: "FullScreen", bundle: nil)
        let destinationVC: FullScreenViewController = storyboard.instantiateViewController(withIdentifier: "FullScreen") as! FullScreenViewController
        destinationVC.router?.dataStore?.officeElement = dataStore?.officeElement
        
        destinationVC.router?.dataStore?.selectedImageIndex = index
        self.viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    
    weak var viewController: OfficeDetailViewController?
    var dataStore: OfficeDetailDataStore?
    
}
