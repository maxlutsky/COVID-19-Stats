//
//  CountryCell.swift
//  COVID-19 Stats
//
//  Created by Max on 20/03/2020.
//  Copyright © 2020 Max. All rights reserved.
//

import UIKit

class CountryCell: UITableViewCell {


    @IBOutlet weak var countryCell: UILabel!
    
    
    
    func addCountry(countryLabel: String){
        
        countryCell.text = countryLabel
        
    }
}
