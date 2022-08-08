//
//  FullScreenModels.swift
//  FindMyOffice
//
//  Created by Emincan on 8.08.2022.
//

import Foundation

// swiftlint:disable nesting
enum FullScreen {
    
    enum Fetch {
        
        struct Request {
            
        }
        
        struct Response {
            var responseImages: OfficeResponseElement?
        }
        
        struct ViewModel {
            var images: [String]
        }
        
    }
    
}
// swiftlint:enable nesting
