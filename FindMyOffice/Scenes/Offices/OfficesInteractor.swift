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
protocol GetFilteredData: AnyObject{
    func filterRequest(request: String)
}
//protocol GetFromCoreData: AnyObject{
//
//    func retriveData(idArray: [Int])
//}

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

extension OfficesInteractor: GetFilteredData{
    
    
    
    func filterRequest(request: String) {
        let filteredData = officeData?.filter{ result in
            
            return String(result.rooms ?? 0) == request || result.capacity == request || result.space == request
        }
        guard let filteredData = filteredData else {return}
        self.presenter?.presentOffices(response: Offices.Fetch.Response(offices:(filteredData)))
        print(filteredData)
    }


}

//extension OfficesInteractor: GetFromCoreData  {
//  
//    func retriveData(idArray: [Int]) {
//        CoreDataManager().getDataFromCoreData { result in
//            switch result{
//            case .success(let ids):
//                weak var viewController2: OfficesDisplayLogic?
//                viewController2?.displayId(intArray: ids)
//            case .failure(_):
//                print("id getting problem")
//            }
//        }
//    }
//    
//    
//}
