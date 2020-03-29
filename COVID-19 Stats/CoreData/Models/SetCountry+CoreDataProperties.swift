//
//  SetCountry+CoreDataProperties.swift
//  COVID-19 Stats
//
//  Created by boburcho on 21/03/2020.
//  Copyright © 2020 Max. All rights reserved.
//
//

import Foundation
import CoreData


extension SetCountry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SetCountry> {
        return NSFetchRequest<SetCountry>(entityName: "SetCountry")
    }

    @NSManaged public var allCountyJSON: Data?
    @NSManaged public var date: String?

}
