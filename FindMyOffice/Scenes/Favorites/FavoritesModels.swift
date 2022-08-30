//
//  FavoritesModels.swift
//  FindMyOffice
//
//  Created by Emincan on 15.08.2022.
//

import Foundation

// swiftlint:disable nesting
enum Favorites {
    
    enum Case {
        
        struct Request {
            
        }
        
        struct Response {
            
        }
        
        struct ViewModel {
            var CoreDataModels: [Favorites.Case.ViewModel.ModelForCoreData]
            
            struct ModelForCoreData{
                                var id: Int16?
                                var name: String?
                                var address: String?
                                var capacity: String?
                                var rooms: String?
                                var space: String?
                                var image: String?
                                var images: [String]?
                                var latitude: Double?
                                var longitude: Double?
                
                
                init(id:Int16?,name:String?,address:String?,capacity:String?,rooms:String?,space:String?,image:String?,images:[String]?,latitude:Double?,longitude:Double?){
                    self.id = id
                    self.name = name
                    self.capacity = capacity
                    self.rooms = rooms
                    self.space = space
                    self.address = address
                    self.image = image
                    self.images = images
                    self.latitude = latitude
                    self.longitude = longitude
                    
                }
                
                init(office: OfficeModel) {
                                  self.init( id: office.id,
                                             name: office.name,
                                             address: office.address,
                                             capacity: office.capacity,
                                             rooms: office.rooms,
                                             space: office.space,
                                             image: office.image,
                                             images: office.images as? [String],
                                             latitude: office.latitude,
                                             longitude: office.longitude)
                               }
                
            }
        }
        
    }
    
}
// swiftlint:enable nesting
