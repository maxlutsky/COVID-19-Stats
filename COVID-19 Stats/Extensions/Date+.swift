//
//  Date+.swift
//  COVID-19 Stats
//
//  Created by boburcho on 21/03/2020.
//  Copyright © 2020 Max. All rights reserved.
//

import Foundation

extension Date
{
    func toString( dateFormat format  : String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func getDateToday() -> String {
        let today = Date()
        let dateImage = today.toString(dateFormat: "yyyy-MM-dd")
        return dateImage
    }
}
