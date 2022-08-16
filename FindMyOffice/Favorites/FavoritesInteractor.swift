//
//  FavoritesInteractor.swift
//  FindMyOffice
//
//  Created by Emincan on 15.08.2022.
//

import Foundation

protocol FavoritesBusinessLogic: AnyObject {
    
}

protocol FavoritesDataStore: AnyObject {
    
}

final class FavoritesInteractor: FavoritesBusinessLogic, FavoritesDataStore {
    
    var presenter: FavoritesPresentationLogic?
    var worker: FavoritesWorkingLogic = FavoritesWorker()
    
}
