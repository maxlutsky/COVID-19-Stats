//
//  DetailsViewController.swift
//  COVID-19 Stats
//
//  Created by Max on 21/03/2020.
//  Copyright © 2020 Max. All rights reserved.
//

import UIKit
import Charts

class DetailsViewController: UIViewController {
    
    let restService = RestService.shared
    let url = "https://corona.lmao.ninja/countries/"

    @IBOutlet weak var countryLabel: UILabel!
    
    @IBOutlet weak var deathLabel: UILabel!
    @IBOutlet weak var deathNumber: UILabel!

    @IBOutlet weak var totalCaselabel: UILabel!
    @IBOutlet weak var totalCaseNumber: UILabel!
    
    @IBOutlet weak var newCaseLabel: UILabel!
    @IBOutlet weak var newCaseNumber: UILabel!
    
    @IBOutlet weak var recoverlabel: UILabel!
    @IBOutlet weak var recoverednumber: UILabel!
    
    @IBOutlet weak var lineChart: LineChartView!
    

    var stats:Stats?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryLabel.text = stats?.country
        
        showData()
        setChartvalue()
        
        fetchDetailsCountry()
//        casesLabel.text = String(stats?.cases)
        // Do any additional setup after loading the view.
    }
    
    func fetchHistoricData() {
        
    }
    
    func fetchDetailsCountry() {
//        guard let statsCountry = stats else { return }
//        let fullURL = url + statsCountry.country
        restService.fetchGenericData(url, httpMethod: .get) { (data: Stats) in
            print(data)
        }
    }
    
    func setChartvalue() {
        let values = (0...15).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(UInt32(15)) + 3)
            return ChartDataEntry(x: Double(i), y: val)
        }
        
        let set1 = LineChartDataSet(entries: values, label: "Data set 1")
        let data = LineChartData(dataSet: set1)
        
        self.lineChart.data = data
        
    }
    
    func showData() {
        guard let statsUnwraped = stats else { return }
        
        deathLabel.text = "Death"
        deathNumber.text = String(statsUnwraped.deaths)
        
        totalCaselabel.text = "Total cases"
        totalCaseNumber.text = String(statsUnwraped.cases)
        
        newCaseLabel.text = "New cases"
        newCaseNumber.text = String(statsUnwraped.todayCases)
        
        recoverlabel.text = "Recovered"
        recoverednumber.text = String(statsUnwraped.recovered)
    }
}
