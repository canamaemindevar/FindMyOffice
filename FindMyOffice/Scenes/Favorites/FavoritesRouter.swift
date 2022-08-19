//
//  FavoritesRouter.swift
//  FindMyOffice
//
//  Created by Emincan on 15.08.2022.
//

import Foundation
import UIKit

protocol FavoritesRoutingLogic: AnyObject {
    
}

protocol FavoritesDataPassing: AnyObject {
    var dataStore: FavoritesDataStore? { get }
}


final class FavoritesRouter: FavoritesRoutingLogic, FavoritesDataPassing {
    
  
    
    weak var viewController: FavoritesViewController?
    var dataStore: FavoritesDataStore?
    
}
