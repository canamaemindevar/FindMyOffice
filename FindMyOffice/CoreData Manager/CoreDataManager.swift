//
//  CoreDataManager.swift
//  FindMyOffice
//
//  Created by Emincan on 24.08.2022.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager{
    static let shared = CoreDataManager()
    
    // get
    func getFavoriteIdFromCoreData(complationHandler: @escaping ((Result<[Int], Error>) -> Void)){
            var idArray: [Int] = []
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "OfficeModel")

            fetchRequest.returnsObjectsAsFaults = false
            do {
                let data = try context.fetch(fetchRequest)
                for result in data as! [NSManagedObject] {
                    if let id = result.value(forKey: "id") as? Int{
                        idArray.append(id)
                    }
                }
                complationHandler(.success(idArray))
            }
            catch {
                complationHandler(.failure(error))
            }
        }
    // save
    func saveCoreData(with viewModel: Offices.Fetch.ViewModel.Office){
        if let appDelegate = UIApplication.shared.delegate as?AppDelegate{
            let context = appDelegate.persistentContainer.viewContext

            let entityDescription = NSEntityDescription.insertNewObject(forEntityName: "OfficeModel", into: context)
           // entityDescription.setValue(viewModel.images, forKey: "images")
            entityDescription.setValue(viewModel.name, forKey: "name")
            entityDescription.setValue(viewModel.rooms, forKey: "rooms")
            entityDescription.setValue(viewModel.address, forKey: "adress")
            entityDescription.setValue(viewModel.capacity, forKey: "capacity")
            entityDescription.setValue(viewModel.image, forKey: "image")
            entityDescription.setValue(viewModel.id, forKey: "id")
            entityDescription.setValue(true, forKey: "fav")
            do{
                try context.save()
                print("Saved")
            }catch{
                print("Saving Error")
            }
    }


        }
    // delete
    
    func deleteCoreData(with dataId: Int){
        
        if let appDelegate = UIApplication.shared.delegate as?AppDelegate {
                      let context = appDelegate.persistentContainer.viewContext
      
                      let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"OfficeModel")
                      fetchRequest.returnsObjectsAsFaults = false
      

                      fetchRequest.predicate = NSPredicate(format: "id = %@", "\(dataId)")
      
                      do{
                          let results = try context.fetch(fetchRequest)
      
                          if results.count>0{
                              for result in results as! [NSManagedObject] {
      
                                  context.delete(result)
                                  print("sildim mi")
                                  do {
                                      try context.save()
                                  } catch  {
                                      print("error saving")
                                  }
      
                              }
                          }
                      } catch {
                          print("error deleting")
                      }
      
                  }
              }
          
        
    func getDataFromCoreData(completion: @escaping ((Result<[Int],Error>) -> Void)){
        var idArray:[Int] = []
        if let appDelegate = UIApplication.shared.delegate as?AppDelegate {
            let context = appDelegate.persistentContainer.viewContext

            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"OfficeModel")
            fetchRequest.returnsObjectsAsFaults = false

            do {
                let results = try context.fetch(fetchRequest)
                for result in results as! [NSManagedObject] {
                    if let idFromCore = result.value(forKey: "id") as? Int {
                        idArray.append(idFromCore)
                      
                    }
                }
                completion(.success(idArray))
                
            } catch  {
                completion(.failure(error))
                print("Retive Data Error")
            }

        }

    }
    
    
    
    
}

    
    
    

