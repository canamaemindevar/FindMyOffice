//
//  WebsiteInteractor.swift
//  FindMyOffice
//
//  Created by Emincan on 19.08.2022.
//

import Foundation

protocol WebsiteBusinessLogic: AnyObject {
    
}

protocol WebsiteDataStore: AnyObject {
    
}

final class WebsiteInteractor: WebsiteBusinessLogic, WebsiteDataStore {
    
    var presenter: WebsitePresentationLogic?
    var worker: WebsiteWorkingLogic = WebsiteWorker()
    
}
