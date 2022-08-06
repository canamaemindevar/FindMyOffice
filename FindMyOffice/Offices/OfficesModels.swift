//
//  OfficesModels.swift
//  FindMyOffice
//
//  Created by Emincan on 4.08.2022.
//

import Foundation

// swiftlint:disable nesting
enum Offices {
    
    enum Fetch {
        
        struct Request {
            
        }
        
        struct Response {
            let offices: OfficeResponse
        }
        
        struct ViewModel {
            var offices:[Offices.Fetch.ViewModel.Office]
         
            
            struct Office {
                let name : String?
                let image : String?
                let rooms: String?
            }
        }
        
    }
    
}
// swiftlint:enable nesting
