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
    var cases: DateWithCount2?
    var deaths: DateWithCount?
    var recovered: DateWithCount?
    
    init(_ dictionary: [String: Any]) {
        self.cases = dictionary["cases"] as? DateWithCount2
        self.deaths = dictionary["deaths"] as? DateWithCount
        self.recovered = dictionary["recovered"] as? DateWithCount
    }
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
        self.day1 = dictionary["3/1/20"] as?    String ?? ""
        self.day2 = dictionary["3/2/20"] as?    String ?? ""
        self.day3 = dictionary["3/3/20"] as?    String ?? ""
        self.day4 = dictionary["3/4/20"] as?    String ?? ""
        self.day5 = dictionary["3/5/20"] as?    String ?? ""
        self.day6 = dictionary["3/6/20"] as?    String ?? ""
        self.day7 = dictionary["3/7/20"] as?    String ?? ""
        self.day8 = dictionary["3/8/20"] as?    String ?? ""
        self.day9 = dictionary["3/9/20"] as?    String ?? ""
        self.day10 = dictionary["3/10/20"] as?  String ?? ""
        self.day11 = dictionary["3/11/20"] as?  String ?? ""
        self.day12 = dictionary["3/12/20"] as?  String ?? ""
        self.day13 = dictionary["3/13/20"] as?  String ?? ""
        self.day14 = dictionary["3/14/20"] as?  String ?? ""
        self.day15 = dictionary["3/15/20"] as?  String ?? ""
        self.day16 = dictionary["3/16/20"] as?  String ?? ""
        self.day17 = dictionary["3/17/20"] as?  String ?? ""
        self.day18 = dictionary["3/18/20"] as?  String ?? ""
        self.day19 = dictionary["3/19/20"] as?  String ?? ""
        self.day20 = dictionary["3/20/20"] as?  String ?? ""
        self.day21 = dictionary["3/21/20"] as?  String ?? ""
        self.day22 = dictionary["3/22/20"] as?  String ?? ""
    }
}

struct DateWithCount2: Codable {
    var day1:  Int?
    var day2:  Int?
    var day3:  Int?
    var day4:  Int?
    var day5:  Int?
    var day6:  Int?
    var day7:  Int?
    var day8:  Int?
    var day9:  Int?
    var day10: Int?
    var day11: Int?
    var day12: Int?
    var day13: Int?
    var day14: Int?
    var day15: Int?
    var day16: Int?
    var day17: Int?
    var day18: Int?
    var day19: Int?
    var day20: Int?
    var day21: Int?
    var day22: Int?
    
    init(_ dictionary: [String: Int]) {
        self.day1 = dictionary["3/1/20"] as?    Int ?? 0
        self.day2 = dictionary["3/2/20"] as?    Int ?? 0
        self.day3 = dictionary["3/3/20"] as?    Int ?? 0
        self.day4 = dictionary["3/4/20"] as?    Int ?? 0
        self.day5 = dictionary["3/5/20"] as?    Int ?? 0
        self.day6 = dictionary["3/6/20"] as?    Int ?? 0
        self.day7 = dictionary["3/7/20"] as?    Int ?? 0
        self.day8 = dictionary["3/8/20"] as?    Int ?? 0
        self.day9 = dictionary["3/9/20"] as?    Int ?? 0
        self.day10 = dictionary["3/10/20"] as?  Int ?? 0
        self.day11 = dictionary["3/11/20"] as?  Int ?? 0
        self.day12 = dictionary["3/12/20"] as?  Int ?? 0
        self.day13 = dictionary["3/13/20"] as?  Int ?? 0
        self.day14 = dictionary["3/14/20"] as?  Int ?? 0
        self.day15 = dictionary["3/15/20"] as?  Int ?? 0
        self.day16 = dictionary["3/16/20"] as?  Int ?? 0
        self.day17 = dictionary["3/17/20"] as?  Int ?? 0
        self.day18 = dictionary["3/18/20"] as?  Int ?? 0
        self.day19 = dictionary["3/19/20"] as?  Int ?? 0
        self.day20 = dictionary["3/20/20"] as?  Int ?? 0
        self.day21 = dictionary["3/21/20"] as?  Int ?? 0
        self.day22 = dictionary["3/22/20"] as?  Int ?? 0
    }
}
