//
//  MapViewRouter.swift
//  FindMyOffice
//
//  Created by Emincan on 20.08.2022.
//

import Foundation

protocol MapViewRoutingLogic: AnyObject {
    
}

protocol MapViewDataPassing: AnyObject {
    var dataStore: MapViewDataStore? { get }
}

final class MapViewRouter: MapViewRoutingLogic, MapViewDataPassing {
    
    weak var viewController: MapViewViewController?
    var dataStore: MapViewDataStore?
    
}
