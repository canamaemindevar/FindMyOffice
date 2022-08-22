//
//  MapViewInteractor.swift
//  FindMyOffice
//
//  Created by Emincan on 20.08.2022.
//

import Foundation

protocol MapViewBusinessLogic: AnyObject {
    func fetchOffices(request:Offices.Fetch.Request)
  //  func fetchOffices(request: Offices.Fetch.Request)
}

protocol MapViewDataStore: AnyObject {
    var offices: OfficeResponse? { get set }
}

final class MapViewInteractor: MapViewBusinessLogic, MapViewDataStore {
   
    
    var offices: OfficeResponse?
//    func fetchOffices(request: Offices.Fetch.Request) {
//        self.presenter?.presentOfficesLocation(response: Offices.Fetch.Response(offices: offices))
//    }
    func fetchOffices(request: Offices.Fetch.Request) {
        worker.getOffices {[weak self] result in
            switch result {
            case .success(let response):
                self?.offices = response
                if let offices = self?.offices {
                    self?.presenter?.presentOfficesLocation(response: Offices.Fetch.Response(offices: offices))
                    print(offices)
                }
            case .failure(let error):
                print(error)
                
            }
        }

    }
 
    
    var presenter: MapViewPresentationLogic?
    var worker: MapViewWorkingLogic = MapViewWorker()
    
}
