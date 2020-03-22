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
struct HistoricData: Codable {
    var country: String?
    var province: String?
    var timeline: Timeline?
    
    init(_ dictionary: [String: Any]) {
        self.country = dictionary["country"] as? String ?? ""
        self.province = dictionary["province"] as? String ?? ""
        self.timeline = dictionary["timeline"] as? Timeline ?? nil
    }
}

struct Timeline: Codable {
    var cases: [String: String]
    var deaths:  [String: String]
    var recovered:  [String: String]
}

struct DateWithCount: Codable {
    var day1:  String?
    var day2:  String?
    var day3:  String?
    var day4:  String?
    var day5:  String?
    var day6:  String?
    var day7:  String?
    var day8:  String?
    var day9:  String?
    var day10: String?
    var day11: String?
    var day12: String?
    var day13: String?
    var day14: String?
    var day15: String?
    var day16: String?
    var day17: String?
    var day18: String?
    var day19: String?
    var day20: String?
    var day21: String?
    var day22: String?
    
    init(_ dictionary: [String: String]) {
        self.day1 = dictionary["3/1/20"]   ?? ""
        self.day2 = dictionary["3/2/20"]   ?? ""
        self.day3 = dictionary["3/3/20"]   ?? ""
        self.day4 = dictionary["3/4/20"]   ?? ""
        self.day5 = dictionary["3/5/20"]   ?? ""
        self.day6 = dictionary["3/6/20"]   ?? ""
        self.day7 = dictionary["3/7/20"]   ?? ""
        self.day8 = dictionary["3/8/20"]   ?? ""
        self.day9 = dictionary["3/9/20"]   ?? ""
        self.day10 = dictionary["3/10/20"] ?? ""
        self.day11 = dictionary["3/11/20"] ?? ""
        self.day12 = dictionary["3/12/20"] ?? ""
        self.day13 = dictionary["3/13/20"] ?? ""
        self.day14 = dictionary["3/14/20"] ?? ""
        self.day15 = dictionary["3/15/20"] ?? ""
        self.day16 = dictionary["3/16/20"] ?? ""
        self.day17 = dictionary["3/17/20"] ?? ""
        self.day18 = dictionary["3/18/20"] ?? ""
        self.day19 = dictionary["3/19/20"] ?? ""
        self.day20 = dictionary["3/20/20"] ?? ""
        self.day21 = dictionary["3/21/20"] ?? ""
        self.day22 = dictionary["3/22/20"] ?? ""
    }
}
