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
