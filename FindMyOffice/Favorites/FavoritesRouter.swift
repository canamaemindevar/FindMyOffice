//
//  FavoritesRouter.swift
//  FindMyOffice
//
//  Created by Emincan on 15.08.2022.
//

import Foundation

protocol FavoritesRoutingLogic: AnyObject {
    
}

protocol FavoritesDataPassing: class {
    var dataStore: FavoritesDataStore? { get }
}

final class FavoritesRouter: FavoritesRoutingLogic, FavoritesDataPassing {
    
    weak var viewController: FavoritesViewController?
    var dataStore: FavoritesDataStore?
    
}
