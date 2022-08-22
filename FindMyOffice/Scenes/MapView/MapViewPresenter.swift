//
//  MapViewPresenter.swift
//  FindMyOffice
//
//  Created by Emincan on 20.08.2022.
//

import Foundation

protocol MapViewPresentationLogic: AnyObject {
    func presentOfficesLocation(response: Offices.Fetch.Response)
}

final class MapViewPresenter: MapViewPresentationLogic {
    
    func presentOfficesLocation(response: Offices.Fetch.Response) {
        
        var officePresent: [Offices.Fetch.ViewModel.Office] = []
        
        response.offices.forEach {
            officePresent.append(Offices.Fetch.ViewModel.Office(name: $0.name,  rooms: String($0.rooms ?? 0),image: $0.image, id: String($0.id ?? 0),location: Offices.Fetch.ViewModel.Location(latitude: $0.location?.latitude, longitude: $0.location?.longitude) ))
            }
            
            viewController?.displayOfficeLocation(viewModels: Offices.Fetch.ViewModel(offices: officePresent))
        print(officePresent)
    }
    
    weak var viewController: MapViewDisplayLogic?
    
}
