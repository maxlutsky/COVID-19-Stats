//
//  ViewController.swift
//  COVID-19 Stats
//
//  Created by Max on 20/03/2020.
//  Copyright © 2020 Max. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var countries: [String] = []
    var stats: [Stats] = []
    

    override func viewDidLoad() {
    
        super.viewDidLoad()
        
//        countries = ["United States", "Ukraine", "Italy", "Great Britain", "China", "Russia"]
        
        guard let url = URL(string: "https://corona.lmao.ninja/countries") else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let dataResponse = data,
                  error == nil else {
                  print(error?.localizedDescription ?? "Response Error")
                  return
                    
            }
            do{
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
//                print(jsonResponse)
                guard let jsonArray = jsonResponse as? [[String: Any]] else {
                      return
                }
                
                for dic in jsonArray{
                    self.stats.append(Stats(dic))
                }
                print(self.stats[0])
                
             } catch let parsingError {
                print("Error", parsingError)
           }
        }
        task.resume()
        
        tableView.delegate = self
        tableView.dataSource = self
//        print(jsonArray)
        
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let country = stats[indexPath.row].country
        let cases = stats[indexPath.row].cases
        let death = stats[indexPath.row].deaths
        
        print(stats[indexPath.row])
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCellId") as! CountryCell
        
        cell.addCountry(countryLabel: country, casesLabel: cases, deathLabel: death)
        
        return cell
    }
}
