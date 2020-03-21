//
//  DetailsViewController.swift
//  COVID-19 Stats
//
//  Created by Max on 21/03/2020.
//  Copyright © 2020 Max. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    


    @IBOutlet weak var countryLabel: UILabel!
    
    var stats:Stats?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryLabel.text = stats?.country

        
        
//        casesLabel.text = String(stats?.cases)
        // Do any additional setup after loading the view.
    }
    


}
