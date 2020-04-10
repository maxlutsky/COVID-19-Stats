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
    let dataService = DataService.shared
    let url = "https://corona.lmao.ninja/countries/"

    @IBOutlet weak var countryLabel: UILabel!
    
    @IBOutlet weak var deathLabel: UILabel!
    @IBOutlet weak var deathNumber: UILabel!

    @IBOutlet weak var favoritesButtonOutlet: UIButton!
    @IBOutlet weak var totalCaselabel: UILabel!
    @IBOutlet weak var totalCaseNumber: UILabel!
    
    @IBOutlet weak var newCaseLabel: UILabel!
    @IBOutlet weak var newCaseNumber: UILabel!
    
    @IBOutlet weak var recoverlabel: UILabel!
    @IBOutlet weak var recoverednumber: UILabel!
    
    @IBOutlet weak var lineChart: LineChartView!

    var stats: Stats?
    var country: HistoricData?
    var countDataTotal: [String] = []
    var countDataRecovered: [String] = []
    var countDataDead: [String] = []
    var settings:UIBarButtonItem = UIBarButtonItem()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryLabel.text = stats?.country
        let buttonIcon = UIImage(named: "Settings")
        let favoritesButtonIcon = UIImage(named: "Star")
        settings = UIBarButtonItem.init(title: "Settings", style: .plain, target: self, action: #selector(openSettings))
        settings.image = buttonIcon
        favoritesButtonOutlet.setImage(favoritesButtonIcon, for: .normal)
        navigationItem.title = "Details"
        navigationItem.rightBarButtonItems = [settings]
        showData()
        if (country == nil) {
            parseHistoricData()
            parseFromDictionary()
//            print(countDataTotal)
//            setChartvalue(arrayCases: countDataTotal)
        }
    }
    
    @IBAction func showTotal(_ sender: Any) {
        setChartvalue(arrayCases: countDataTotal)
    }
    
    func fetchDetailsCountry() {
//        guard let statsCountry = stats else { return }
//        let fullURL = url + statsCountry.country
        restService.fetchGenericData(url, httpMethod: .get) { (data: Stats) in
            print(data)
        }
    }
        
    @IBAction func showRecovered(_ sender: Any) {
        setChartvalue(arrayCases: countDataRecovered)
    }
    
    @IBAction func showDead(_ sender: Any) {
        setChartvalue(arrayCases: countDataDead)
    }
    
    
    func parseHistoricData() {
        for object in dataService.historicData {
            guard let objectCountry = object.country else { return }
            if objectCountry == stats!.country {
                country = object
            }
        }
    }
    
    func parseFromDictionary() {
        guard let historicDatacountry = country else { return }
        for obj in dataService.dates {
            if let count = historicDatacountry.timeline?.cases[obj] {
                countDataTotal.append(count)
            }
            if let count = historicDatacountry.timeline?.recovered[obj] {
                countDataRecovered.append(count)
            }
            if let count = historicDatacountry.timeline?.deaths[obj] {
                countDataDead.append(count)
            }
        }
        
        lineChart.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
    }
    
    func setChartvalue(arrayCases : [String]) {
        print(countDataTotal.count)
        let values = (0...(countDataTotal.count - 1)).map { (i) -> ChartDataEntry in
            let val = Double(arrayCases[i])
            return ChartDataEntry(x: Double(i + 2), y: val ?? 1)
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
        
        newCaseLabel.text = "Recovered"
        newCaseNumber.text = String(statsUnwraped.recovered)
        
        recoverlabel.text = "Dead"
        recoverednumber.text = String(statsUnwraped.deaths)
        
        lineChart.borderColor = UIColor.red
    }
    @IBAction func favoritesButtonAction(_ sender: Any) {
        
        favoritesButtonOutlet.setImage(UIImage(named: "FilledStar"), for: .normal)
        
        
        let favorites = UserDefaults.standard.stringArray(forKey: "Favorites")
        var favoritesVar: [String] = favorites ?? []
        if !(stats?.favorite ?? false){
            favoritesVar.append(stats!.country)
            stats?.favorite = true
            print(stats!.country)
        }

        UserDefaults.standard.set(favoritesVar, forKey: "Favorites")
    }
    
    @objc func openSettings(){
        let settingsViewController = storyboard?.instantiateViewController(identifier: "SettingsViewController") as! SettingsViewController
        navigationController?.pushViewController(settingsViewController, animated: true)
    }
}
