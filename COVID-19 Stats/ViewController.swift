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
    
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    
    var stats: [Stats] = []
    var filteredStats: [Stats] = []
    var favoriteStats: [Stats] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    var settings:UIBarButtonItem = UIBarButtonItem()
    var favoritesButton:UIBarButtonItem = UIBarButtonItem()
    var favorites = UserDefaults.standard.array(forKey: "Favorites")
    var displayFavorites = false

    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let buttonIcon = UIImage(named: "Settings")
        let favoritesButtonIcon = UIImage(named: "Star")
        settings = UIBarButtonItem.init(title: "Settings", style: .plain, target: self, action: #selector(openSettings))
        settings.image = buttonIcon
        favoritesButton = UIBarButtonItem.init(title: "favorites", style: .plain, target: self, action: #selector(switchFavorites))
        favoritesButton.image = favoritesButtonIcon
        navigationItem.leftBarButtonItems = [favoritesButton]
        navigationItem.title = "Covid-19"
        navigationItem.rightBarButtonItems = [settings]
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Countries"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        
        
        
        requestData()
        dataService.fetchDetailsHistoric()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("View APPEARED\n")
        if !(stats.isEmpty){
            stats = applyFavorites(stats: stats)
            print("DATA UDPATED")
        }
        if dataService.historicData.count > 0 {
            print(dataService.historicData[0].timeline?.cases["3/21/20"])
        }

    }
    
    
    func filterContentForSearchText(_ searchText: String) {
        
        if displayFavorites {
            filteredStats = favoriteStats.filter { (stats: Stats) -> Bool in
                return stats.country.lowercased().contains(searchText.lowercased())
            }
        }else{
            filteredStats = stats.filter { (stats: Stats) -> Bool in
                return stats.country.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
    
    func filterForFavorites(){
        favoriteStats = stats.filter { (stats: Stats) -> Bool in
            return stats.favorite ?? false
        }
    }
    
    
    
    @objc func openSettings(){
        let settingsViewController = storyboard?.instantiateViewController(identifier: "SettingsViewController") as! SettingsViewController
        navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
    @objc func switchFavorites(){
        filterForFavorites()
        if displayFavorites {
            displayFavorites = false
        }else{
            displayFavorites = true
        }
        tableView.reloadData()
    }
}

    //MARK: Extensions

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if isFiltering {
            return filteredStats.count
        }
        
        if displayFavorites{
            return favoriteStats.count
        }else{
            return stats.count
        }
        
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCellId") as! CountryCell
        
        if isFiltering {
            cell.addCountry(tempStat: filteredStats[indexPath.row])
        } else {
            if displayFavorites{
                cell.addCountry(tempStat: favoriteStats[indexPath.row])
            }else{
                cell.addCountry(tempStat: stats[indexPath.row])
            }
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailsViewController = storyboard?.instantiateViewController(identifier: "DetailsViewController") as! DetailsViewController
        navigationController?.pushViewController(detailsViewController, animated: true)
        if isFiltering {
            detailsViewController.stats = filteredStats[indexPath.row]
        } else {
            if displayFavorites{
                detailsViewController.stats = favoriteStats[indexPath.row]
            } else {
                detailsViewController.stats = stats[indexPath.row]
            }
        }
        
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
                
                self.stats = self.applyFavorites(stats: self.stats)
                
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
    
    func applyFavorites(stats: [Stats]) -> [Stats]{
        guard let favorites = UserDefaults.standard.stringArray(forKey: "Favorites") else { print("NOFAVS\n"); return stats }
        var statsTemp = stats
          
            for i in 0 ..< (statsTemp.count - 1){
                
                if favorites.contains(statsTemp[i].country){
                    statsTemp[i].favorite = true
                }else{
                    statsTemp[i].favorite = false
                }
            }

        return statsTemp
    }
}


extension ViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    filterContentForSearchText(searchBar.text!)
  }
}
