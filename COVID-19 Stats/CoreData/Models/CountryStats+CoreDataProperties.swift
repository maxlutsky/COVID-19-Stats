//
//  CountryStats+CoreDataProperties.swift
//  COVID-19 Stats
//
//  Created by boburcho on 21/03/2020.
//  Copyright © 2020 Max. All rights reserved.
//
//

import Foundation
import CoreData


extension CountryStats {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CountryStats> {
        return NSFetchRequest<CountryStats>(entityName: "CountryStats")
    }

    @NSManaged public var country: String?
    @NSManaged public var cases: Int16
    @NSManaged public var todayCases: Int16

}
