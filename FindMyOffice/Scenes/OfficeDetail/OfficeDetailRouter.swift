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
    func routeToWebSite()
}


protocol OfficeDetailDataPassing: AnyObject {
    var dataStore: OfficeDetailDataStore? { get }
}

final class OfficeDetailRouter: OfficeDetailRoutingLogic, OfficeDetailDataPassing {
    func routeToWebSite() {
        let storyboard = UIStoryboard(name: "Website", bundle: nil)
        let destinationVC: WebsiteViewController = storyboard.instantiateViewController(withIdentifier: "WebsiteViewController") as! WebsiteViewController
       
        self.viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func routeToFullScreen(index: Int) {
        

        let storyboard = UIStoryboard(name: "FullScreen", bundle: nil)
        let destinationVC: FullScreenViewController = storyboard.instantiateViewController(withIdentifier: "FullScreen") as! FullScreenViewController
        destinationVC.router?.dataStore?.officeElement = dataStore?.officeElement
        
        destinationVC.router?.dataStore?.selectedImageIndex = index
        destinationVC.delegate = viewController 
        self.viewController?.navigationController?.pushViewController(destinationVC, animated: true)
        
    }
    
    
    weak var viewController: OfficeDetailViewController?
    var dataStore: OfficeDetailDataStore?
    
}
