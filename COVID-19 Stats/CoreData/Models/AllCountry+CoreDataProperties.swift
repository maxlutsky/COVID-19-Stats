//
//  AllCountry+CoreDataProperties.swift
//  COVID-19 Stats
//
//  Created by boburcho on 21/03/2020.
//  Copyright © 2020 Max. All rights reserved.
//
//

import Foundation
import CoreData


extension AllCountry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AllCountry> {
        return NSFetchRequest<AllCountry>(entityName: "AllCountry")
    }

    @NSManaged public var allCountryJSON: Data?
    @NSManaged public var date: String?

}
