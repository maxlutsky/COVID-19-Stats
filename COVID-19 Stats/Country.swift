//
//  Country.swift
//  COVID-19 Stats
//
//  Created by Max on 20/03/2020.
//  Copyright © 2020 Max. All rights reserved.
//

import Foundation

struct Stats: Codable {
    var country: String
    var cases: Int
    var todayCases: Int
    var deaths: Int
    var todayDeaths: Int
    var recovered: Int
    var active: Int
    var critical: Int
    var casesPerOneMillion: Double?
    var favorite: Bool? 
    
}

