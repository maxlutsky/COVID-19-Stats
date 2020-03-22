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
    
    var all: [HistoricData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryLabel.text = stats?.country
        
        showData()
        setChartvalue()
        
//        fetchDetailsCountry()
//        casesLabel.text = String(stats?.cases)
        // Do any additional setup after loading the view.
        
        fetchDetailsHistoric()
    }
    
    func fetchHistoricData() {
        
    }
    
    func fetchDetailsCountry() {
        guard let statsCountry = stats else { return }
        let fullURL = url + statsCountry.country
        restService.fetchGenericData(fullURL, httpMethod: .get) { (data: Stats) in
            print("fetchGenericData: \(data)")
        }
    }
    
    func fetchDetailsHistoric() {
        let fullURL = "https://corona.lmao.ninja/historical"
        restService.fetchGenericData(fullURL, httpMethod: .get) { (data: [HistoricData2]) in
            let count = data[0].timeline?.cases["3/21/20"]
            print(count)
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

struct HistoricData2: Codable {
    var country: String?
    var province: String?
    var timeline: Timeline2?
    
    init(_ dictionary: [String: Any]) {
        self.country = dictionary["country"] as? String ?? ""
        self.province = dictionary["province"] as? String ?? ""
        self.timeline = dictionary["timeline"] as? Timeline2 ?? nil
    }
}

struct Timeline2: Codable {
    var cases: [String: String]
    var deaths:  [String: String]
    var recovered:  [String: String]
    
//    init(_ dictionary: [String: Any]) {
//        self.cases = dictionary["cases"] as? DateWithCount2
//        self.deaths = dictionary["deaths"] as? DateWithCount
//        self.recovered = dictionary["recovered"] as? DateWithCount
//    }
}



struct NearEarthObject: Codable {
    let referenceID:String
    let name:String
    let imageURL:URL

    private enum CodingKeys: String, CodingKey {
        case referenceID = "neo_reference_id"
        case name
        case imageURL = "nasa_jpl_url"
    }
}

struct NEOApiResponse: Codable {
    let nearEarthObjects: [String:[NearEarthObject]]

    private enum CodingKeys: String,CodingKey {
        case nearEarthObjects = "near_earth_objects"
    }
}

//do {
//    let decodedResponse = try JSONDecoder().decode(NEOApiResponse.self, from: data)
//} catch {
//    print(error)
//}
