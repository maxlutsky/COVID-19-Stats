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
    
//    func delete() {
//        
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "COVID19")
//        fetchRequest.returnsObjectsAsFaults = false
//
//        do
//        {
//            let results = try context.fetch(fetchRequest)
//            for managedObject in results
//            {
//                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
//                context.delete(managedObjectData)
//            }
//        } catch let error as NSError {
//            print("Detele all my data in  error : \(error.userInfo)")
//        }
//    }

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
    
    func fetchWithPatch(filterBy: String, find: String, newVersion: Data) {

        let entityName = String(describing: AllCountry.self)

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)

        fetchRequest.predicate = NSPredicate(format: "\(filterBy) == %@", find)

        do {
            let fetchObjects = try context.fetch(fetchRequest) as? [AllCountry]
            
            guard let unwrapFetchObjects = fetchObjects else { return }
            
            if unwrapFetchObjects.count > 0 {
                unwrapFetchObjects[0].setValue(newVersion, forKey: find)
            } else {
                let today = getDateToday()
                let setCountry = AllCountry(context: PersistenceManager.shared.context)
                setCountry.allCountryJSON = newVersion
                setCountry.date = today
            }
            self.save()
        } catch {
            print(error)
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
    
    private func getDateToday() -> String {
        let today = Date()
        let dateImage = today.toString(dateFormat: "yyyy-MM-dd")
        return dateImage
    }
}
