//
//  OfficeDetailModels.swift
//  FindMyOffice
//
//  Created by Emincan on 6.08.2022.
//

import Foundation

// swiftlint:disable nesting
enum OfficeDetail {
    
    enum Fetch {
        
        struct Request {
            
        }
        
        struct Response {
            let officeDetail: OfficeResponseElement?
        }
        
        struct ViewModel {
            
            var name: String?
            var address: String?
            var rooms: Int?
            var capacity: String?
            var space: String?
            var image: String?
            var images: Media?
            var latitude: Double?
            var longitude: Double?
            
            struct Media{
                var url: [String]?
                var isVideo: Bool?
            }
        }
        
    }
    
}
// swiftlint:enable nesting
