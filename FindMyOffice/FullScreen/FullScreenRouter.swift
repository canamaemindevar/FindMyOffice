//
//  FullScreenRouter.swift
//  FindMyOffice
//
//  Created by Emincan on 8.08.2022.
//

import Foundation
import UIKit

protocol FullScreenRoutingLogic: AnyObject {
    
}

protocol FullScreenDataPassing: AnyObject {
    var dataStore: FullScreenDataStore? { get }
}



final class FullScreenRouter: FullScreenRoutingLogic, FullScreenDataPassing,getIndexFromFull {
    func fullScreenIndexPath(indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC: OfficeDetailViewController = storyboard.instantiateViewController(withIdentifier: "OfficeDetail") as! OfficeDetailViewController
        self.viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    
    weak var viewController: FullScreenViewController?
    var dataStore: FullScreenDataStore?
    
}
