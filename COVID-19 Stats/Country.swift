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
    var casesPerOneMillion: Int
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

struct HistoricData: Codable {
    var country: String
    var province: String
    var timeline: Timeline
}

struct Timeline: Codable {
    var cases: String
    var deaths: String
    var recovered: String
}
