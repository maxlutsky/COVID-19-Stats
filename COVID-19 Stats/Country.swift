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
    var deaths: Int
    
    init(_ dictionary: [String: Any]) {
      self.country = dictionary["country"] as? String ?? ""
      self.cases = dictionary["cases"] as? Int ?? 0
      self.deaths = dictionary["deaths"] as? Int ?? 0
    }
}


