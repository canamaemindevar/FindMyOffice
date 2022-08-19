//
//  OfficeDetailInteractor.swift
//  FindMyOffice
//
//  Created by Emincan on 6.08.2022.
//

import Foundation

protocol OfficeDetailBusinessLogic: AnyObject {
    func fetchOfficeDetail(request: OfficeDetail.Fetch.Request)
}

protocol OfficeDetailDataStore: AnyObject {
    var officeElement: OfficeResponseElement? { get set }
}

final class OfficeDetailInteractor: OfficeDetailBusinessLogic, OfficeDetailDataStore {
    var officeElement: OfficeResponseElement?
    
    
    
    func fetchOfficeDetail(request: OfficeDetail.Fetch.Request) {
        self.presenter?.presentOfficeDetail(response: .init(officeDetail: officeElement))
    }
    
    
    
    
    
    var presenter: OfficeDetailPresentationLogic?
    var worker: OfficeDetailWorkingLogic = OfficeDetailWorker()
    
}
