//
//  OfficeDetailInteractor.swift
//  FindMyOffice
//
//  Created by Emincan on 6.08.2022.
//

import Foundation

protocol OfficeDetailBusinessLogic: AnyObject {
    
}

protocol OfficeDetailDataStore: AnyObject {
    
}

final class OfficeDetailInteractor: OfficeDetailBusinessLogic, OfficeDetailDataStore {
    
    var presenter: OfficeDetailPresentationLogic?
    var worker: OfficeDetailWorkingLogic = OfficeDetailWorker()
    
}
