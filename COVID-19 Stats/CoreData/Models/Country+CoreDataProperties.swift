//
//  Country+CoreDataProperties.swift
//  COVID-19 Stats
//
//  Created by boburcho on 21/03/2020.
//  Copyright © 2020 Max. All rights reserved.
//
//

import Foundation
import CoreData


extension Country {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country")
    }

    @NSManaged public var country: String?
    @NSManaged public var cases: Int16
    @NSManaged public var todayCases: Int16
    @NSManaged public var deaths: Int16
    @NSManaged public var todayDeaths: Int16
    @NSManaged public var recovered: Int16
    @NSManaged public var active: Int16
    @NSManaged public var casesPerOneMillion: Int16

}
