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
    
    var stats: [Stats] = []

    override func viewDidLoad() {
        
        super.viewDidLoad()
        requestData()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stats.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCellId") as! CountryCell
        cell.addCountry(tempStat: stats[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        print(stats[indexPath.row])
    }
}

extension ViewController{
    
    func requestData(){
        guard let url = URL(string: "https://corona.lmao.ninja/countries") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let dataResponse = data,
                  error == nil else {
                  print(error?.localizedDescription ?? "Response Error")
                  return
                    
            }
            do {
                //here dataResponse received from a network request
                let decoder = JSONDecoder()
                let model = try decoder.decode([Stats].self, from: dataResponse) //Decode JSON Response Data
                self.stats = model
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
             } catch let parsingError {
                print("Error", parsingError)
           }
        }
        task.resume()
        
    }
    
}
