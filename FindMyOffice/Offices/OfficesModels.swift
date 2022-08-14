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
            
            struct ImageUrls{
                var imageUrl: String?
            }
            
            struct Office {
                var name: String?
                var address: String?
                var rooms: String?
                var capacity: String?
                var space: String?
                var image: String?
                var images: [ImageUrls]?
                
            }
          
        }
        
    }
    
}
struct Options {
    var options: String?
    var values: [String?]

    
}
// swiftlint:enable nesting
