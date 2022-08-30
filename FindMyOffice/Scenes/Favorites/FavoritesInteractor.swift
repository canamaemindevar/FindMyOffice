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
protocol CoreDataFav: AnyObject{
    func coreDataGetFunc(completion: @escaping(([Favorites.Case.ViewModel.ModelForCoreData])->Void))
}

final class FavoritesInteractor: FavoritesBusinessLogic, FavoritesDataStore, CoreDataFav{
    
    func coreDataGetFunc(completion: @escaping(([Favorites.Case.ViewModel.ModelForCoreData])->Void)){
        CoreDataManager().getDataForFavs { result in
            switch result{
                
            case .success(let favOffices):
                completion(favOffices)
            case .failure(_):
                print("Erro in retrieving values")
            }
        }
       
    }
   
    
    
    
    
    var presenter: FavoritesPresentationLogic?
    var worker: FavoritesWorkingLogic = FavoritesWorker()
    
}
