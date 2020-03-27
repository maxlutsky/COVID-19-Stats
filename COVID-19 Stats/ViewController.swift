//
//  ViewController.swift
//  COVID-19 Stats
//
//  Created by Max on 20/03/2020.
//  Copyright © 2020 Max. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    let dataService = DataService.shared
    
    @IBOutlet weak var tableView: UITableView!
    
    var stats: [Stats] = []

    override func viewDidLoad() {
        
        super.viewDidLoad()
        requestData()
        
        dataService.fetchDetailsHistoric()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if dataService.historicData.count > 0 {
            print(dataService.historicData[0].timeline?.cases["3/21/20"])
        }
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
//        print(indexPath)
//        print(stats[indexPath.row])
        
        let detailsViewController = storyboard?.instantiateViewController(identifier: "DetailsViewController") as! DetailsViewController
        navigationController?.pushViewController(detailsViewController, animated: true)
        detailsViewController.stats = stats[indexPath.row]
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
                
                guard let data = data else { return }
                self.dataService.getFromCoreDataAllInstance(data: data)
                
             } catch let parsingError {
                print("Error", parsingError)
           }
        }
        task.resume()
        
    }
    
}
