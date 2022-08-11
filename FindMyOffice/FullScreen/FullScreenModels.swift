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
            var responseImages: [String]?
            var selectedImageIndex: Int?
        }
        
        struct ViewModel {
            var images: [String]
            var selectedImageIndex: Int?
        }
        
    }
    
}
// swiftlint:enable nesting
