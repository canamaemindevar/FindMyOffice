//
//  OfficesPresenter.swift
//  FindMyOffice
//
//  Created by Emincan on 4.08.2022.
//

import Foundation

protocol OfficesPresentationLogic: AnyObject {
    func presentOffices(response: Offices.Fetch.Response)
}

final class OfficesPresenter: OfficesPresentationLogic {
    
   
    
    func presentOffices(response: Offices.Fetch.Response) {
        
        var officePresent: [Offices.Fetch.ViewModel.Office] = []
        
        response.offices.forEach {
            officePresent.append(Offices.Fetch.ViewModel.Office(name: $0.name,  rooms: String($0.rooms ?? 0),image: $0.image, id: String($0.id ?? 0) ))
            }
            
            viewController?.displayOffice(viewModel: Offices.Fetch.ViewModel(offices: officePresent))
    }
    
    
    weak var viewController: OfficesDisplayLogic?
    
}
