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

    var dates = ["3/1/20","3/2/20","3/3/20","3/4/20","3/5/20","3/6/20","3/7/20","3/8/20","3/9/20","3/10/20",
                        "3/11/20","3/12/20","3/13/20","3/14/20","3/15/20","3/16/20","3/17/20","3/18/20","3/19/20",
                        "3/20/20","3/21/20","3/22/20"]
    
    var historicData: [HistoricData] = []
    
    let persistenceManager = PersistenceManager.shared
    let restService = RestService.shared
    
    func fetchDetailsHistoric() {
        let fullURL = "https://corona.lmao.ninja/historical"
        restService.fetchGenericData(fullURL, httpMethod: .get) { (data: [HistoricData]) in
            self.historicData = data
            let count = data[0].timeline?.cases["3/21/20"]
            print(count)
        }
    }
    
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
