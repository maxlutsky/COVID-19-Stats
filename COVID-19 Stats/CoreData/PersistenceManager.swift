//
//  PersistenceManager.swift
//  COVID-19 Stats
//
//  Created by boburcho on 20/03/2020.
//  Copyright © 2020 Max. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class PersistenceManager {
    
    private init() {}
    static let shared = PersistenceManager()
    
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "COVID19")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context = persistentContainer.viewContext

    func save () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetch<T: NSManagedObject>(_ objectType: T.Type) -> [T] {
        
        let entityName = String(describing: objectType)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        do {
            let fetchObjects = try context.fetch(fetchRequest) as? [T]
            return fetchObjects ?? [T]()
            
        } catch {
            print(error)
            return [T]()
        }
        
    }
    
    func fetchWithFilter<T: NSManagedObject>(_ objectType: T.Type, filterBy: String, find: String) -> [T] {
        
        let entityName = String(describing: objectType)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        fetchRequest.predicate = NSPredicate(format: "\(filterBy) == %@", find)
        
        do {
            let fetchObjects = try context.fetch(fetchRequest) as? [T]
            return fetchObjects ?? [T]()
            
        } catch {
            print(error)
            return [T]()
        }
        
    }
    
    func fetchAndDelete<T: NSManagedObject>(_ objectType: T.Type) -> Bool {
        
        let entityName = String(describing: objectType)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        do {
            let fetchObjects = try context.fetch(fetchRequest) as? [T] ?? [T]()
            for object in fetchObjects {
                context.delete(object)
            }
            self.save()
            return true
            
        } catch {
            print(error)
            return false
        }
    }
}

// for use we need create singleton in VC:     let persistenceManager = PersistenceManager.shared
// then use method fetch and save
//         fetch() example
//         let stats = persistenceManager.fetch(Stats.self)
//         myArrayWithStats = stats
//         stats.forEach { (stat) in
//             print(stat)
//         }
//
//         save exmaple
//         let stat = Stats(context: persistenceManager.context)
//         Stats.country = "Brasil"
//         Stats.cases = 35 000
//         ....
//         persistenceManager.save()


//___________________________________ put into VC

//let persistenceManager = PersistenceManager.shared
//
//getFromCoreDataAllInstance()
//
//
//func saveToCoreData(_ JSON: String) {
//    print("try save \(JSON)")
//    let setCountry = SetCountry(context: persistenceManager.context)
//    setCountry.allCountyJSON = JSON
//    persistenceManager.save()
//}
//
//func getFromCoreDataAllInstance() {
//    let setCountry = persistenceManager.fetch(SetCountry.self)
//    print(setCountry)
//    setCountry.forEach { (country) in
//        print("Country number")
//        print(country.allCountyJSON)
//    }
//}
//
//saveToCoreData(String(indexPath.row))
