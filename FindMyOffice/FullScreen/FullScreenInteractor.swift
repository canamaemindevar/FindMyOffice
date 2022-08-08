//
//  FullScreenInteractor.swift
//  FindMyOffice
//
//  Created by Emincan on 8.08.2022.
//

import Foundation

protocol FullScreenBusinessLogic: AnyObject {
    func fetchOfficePics(request: OfficeDetail.Fetch.Request)
}

protocol FullScreenDataStore: AnyObject {
    var officeElement: OfficeResponseElement? { get set }
}

final class FullScreenInteractor: FullScreenBusinessLogic, FullScreenDataStore {
    func fetchOfficePics(request: OfficeDetail.Fetch.Request) {
        self.presenter?.presentPics(response: .init(responseImages: officeElement))
    }
    
    var officeElement: OfficeResponseElement?
    
    
    var presenter: FullScreenPresentationLogic?
    var worker: FullScreenWorkingLogic = FullScreenWorker()
    
}
