//
//  NetworkManager.swift
//  FindMyOffice
//
//  Created by Emincan on 4.08.2022.
//

import Foundation
protocol NetworkManagerProtocol{
    func getOffice(completion: @escaping ((Result<OfficeResponse,Error>) -> Void))
}



// completion: @escaping (OfficeResponse?) -> Void
struct NetworkManager: NetworkManagerProtocol{
    
    
    func getOffice(completion: @escaping ((Result<OfficeResponse,Error>) -> Void)){
    let fullUrl = "\(API.url)"
        guard let url = URL(string: fullUrl) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data , error == nil else {
                return
        }
            let officeJson = try? JSONDecoder().decode(OfficeResponse.self, from: data)
            if let officeJson = officeJson {
            completion(.success(officeJson))
            }
            
            
        }
        .resume()
        
    }
    
}
