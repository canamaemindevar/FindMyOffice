//
//  FullScreenRouter.swift
//  FindMyOffice
//
//  Created by Emincan on 8.08.2022.
//

import Foundation

protocol FullScreenRoutingLogic: AnyObject {
    
}

protocol FullScreenDataPassing: class {
    var dataStore: FullScreenDataStore? { get }
}

final class FullScreenRouter: FullScreenRoutingLogic, FullScreenDataPassing {
    
    weak var viewController: FullScreenViewController?
    var dataStore: FullScreenDataStore?
    
}
