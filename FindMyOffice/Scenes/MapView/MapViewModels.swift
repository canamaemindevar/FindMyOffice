//
//  MapViewModels.swift
//  FindMyOffice
//
//  Created by Emincan on 20.08.2022.
//

import Foundation

// swiftlint:disable nesting
enum MapView {
    
    enum Case {
        
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
                var id: String?
                var location: Location?
                
            }
            struct Location: Codable {
                var latitude, longitude: Double?
            }
          
        }
        
    }
    
}
// swiftlint:enable nesting
