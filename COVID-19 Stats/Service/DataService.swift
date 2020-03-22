//
//  DataService.swift
//  COVID-19 Stats
//
//  Created by boburcho on 21/03/2020.
//  Copyright © 2020 Max. All rights reserved.
//

import Foundation
import UIKit

class DataService {
    static let shared = DataService()
    
    let persistenceManager = PersistenceManager.shared
    
    func setDataToCoreData(_ data: String) {
        print(data)
    }
    
    public func saveToCoreData(_ JSON: Data) {
        let today = getDateToday()
        let setCountry = AllCountry(context: persistenceManager.context)
        setCountry.allCountryJSON = JSON
        setCountry.date = today
        persistenceManager.save()
    }
    
    public func getFromCoreDataAllInstance(data: Data) {
        let setCountry = persistenceManager.fetch(AllCountry.self)
        print(setCountry)
        var semaphore = false
        if setCountry.count > 0 {
            print("update exist entity")
            for object in setCountry {
                print(object.date!)
                if object.date == getDateToday() {
                    semaphore = true
                    object.setValue(data, forKey: "allCountryJSON")
                }
            }
            if !semaphore {
                saveToCoreData(data)
            }
            persistenceManager.save()
        } else {
            print("create new entity")
            saveToCoreData(data)
        }
    }
    
    public func fetchAndDelete() -> Bool {
        return persistenceManager.fetchAndDelete(AllCountry.self)
    }
    
    private func getDateToday() -> String {
        let today = Date()
        let dateImage = today.toString(dateFormat: "yyyy-MM-dd")
        return dateImage
    }
}
