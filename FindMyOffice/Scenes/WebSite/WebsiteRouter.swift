//
//  WebsiteRouter.swift
//  FindMyOffice
//
//  Created by Emincan on 19.08.2022.
//

import Foundation

protocol WebsiteRoutingLogic: AnyObject {
    
}

protocol WebsiteDataPassing: AnyObject {
    var dataStore: WebsiteDataStore? { get }
}

final class WebsiteRouter: WebsiteRoutingLogic, WebsiteDataPassing {
    
    weak var viewController: WebsiteViewController?
    var dataStore: WebsiteDataStore?
    
}
