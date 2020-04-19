//
//  CountryCell.swift
//  COVID-19 Stats
//
//  Created by Max on 20/03/2020.
//  Copyright © 2020 Max. All rights reserved.
//

import UIKit

class CountryCell: UITableViewCell {

    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var casesNumber: UILabel!
    @IBOutlet weak var deathNumber: UILabel!
    

    func addCountry(tempStat: Stats){
        countryName.text = tempStat.country
        casesNumber.text = String(tempStat.cases)
        deathNumber.text = String(tempStat.deaths)
        
    }
}
