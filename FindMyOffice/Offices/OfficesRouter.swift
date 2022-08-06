//
//  OfficesRouter.swift
//  FindMyOffice
//
//  Created by Emincan on 4.08.2022.
//

import Foundation

protocol OfficesRoutingLogic: AnyObject {
    
}

protocol OfficesDataPassing: AnyObject {
    var dataStore: OfficesDataStore? { get }
}

final class OfficesRouter: OfficesRoutingLogic, OfficesDataPassing {
    
    weak var viewController: OfficesViewController?
    var dataStore: OfficesDataStore?
    
}
