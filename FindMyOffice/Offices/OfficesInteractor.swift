//
//  OfficesInteractor.swift
//  FindMyOffice
//
//  Created by Emincan on 4.08.2022.
//

import Foundation

protocol OfficesBusinessLogic: AnyObject {
    func fetchOffices(request:Offices.Fetch.Request)
}

protocol OfficesDataStore: AnyObject {
    var officeData: OfficeResponse? {get}
}

final class OfficesInteractor: OfficesBusinessLogic, OfficesDataStore {
    var officeData: OfficeResponse?
    
    func fetchOffices(request: Offices.Fetch.Request) {
        worker.getOffices {[weak self] result in
            switch result {
            case .success(let response):
                self?.officeData = response
                if let officeData = self?.officeData {
                    self?.presenter?.presentOffices(response: Offices.Fetch.Response(offices: officeData))
                }
            case .failure(let error):
                print(error)
                
            }
        }

    }
    
    
    var presenter: OfficesPresentationLogic?
    var worker: OfficesWorkingLogic = OfficesWorker()
    
}
