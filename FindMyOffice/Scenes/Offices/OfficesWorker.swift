//
//  OfficesWorker.swift
//  FindMyOffice
//
//  Created by Emincan on 4.08.2022.
//

import Foundation

protocol OfficesWorkingLogic: AnyObject {
    func getOffices( completion:@escaping ((Result<OfficeResponse,Error>) -> Void))
}

final class OfficesWorker: OfficesWorkingLogic {
    
        func getOffices(completion: @escaping ((Result<OfficeResponse, Error>) -> Void)) {
            NetworkManager().getOffice { result in
                switch result{
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }

    
    
    
}
