//
//  FullScreenInteractor.swift
//  FindMyOffice
//
//  Created by Emincan on 8.08.2022.
//

import Foundation

protocol FullScreenBusinessLogic: AnyObject {
    func fetchOfficePics(request: OfficeDetail.Fetch.Request)
}

protocol FullScreenDataStore: AnyObject {
    var officeElement: OfficeResponseElement? { get set }
    var selectedImageIndex: Int? { get set }
}


final class FullScreenInteractor: FullScreenBusinessLogic, FullScreenDataStore {
    func fetchOfficePics(request: OfficeDetail.Fetch.Request) {
       
        presenter?.presentPics(response: FullScreen.Fetch.Response(responseImages: officeElement?.images, selectedImageIndex: selectedImageIndex))
    }
    
    var officeElement: OfficeResponseElement?
    var selectedImageIndex: Int?
    
    
    var presenter: FullScreenPresentationLogic?
    var worker: FullScreenWorkingLogic = FullScreenWorker()
    
}
