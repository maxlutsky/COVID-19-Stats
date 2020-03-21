//
//  Country.swift
//  COVID-19 Stats
//
//  Created by Max on 20/03/2020.
//  Copyright © 2020 Max. All rights reserved.
//

import Foundation

struct Stats: Decodable {
    var country: String
    var cases: Int
    var todayCases: Int
    var deaths: Int
    var todayDeaths: Int
    var recovered: Int
    var active: Int
    var critical: Int
    var casesPerOneMillion: Int
    
    init(_ dictionary: [String: Any]) {
        self.country = dictionary["country"] as? String ?? ""
        self.cases = dictionary["cases"] as? Int ?? 0
        self.todayCases = dictionary ["todayCases"] as? Int ?? 0
        self.deaths = dictionary["deaths"] as? Int ?? 0
        self.todayDeaths = dictionary["todayDeaths"] as? Int ?? 0
        self.recovered = dictionary["recovered"] as? Int ?? 0
        self.active = dictionary["active"] as? Int ?? 0
        self.critical = dictionary["critical"] as? Int ?? 0
        self.casesPerOneMillion = dictionary["casesPerOneMillion"] as? Int ?? 0
    }
}

//{
//    "country":"Portugal",
//    "cases":1020,
//    "todayCases":0,
//    "deaths":6,
//    "todayDeaths":0,
//    "recovered":5,
//    "active":1009,
//    "critical":26,
//    "casesPerOneMillion":100
//
//},
