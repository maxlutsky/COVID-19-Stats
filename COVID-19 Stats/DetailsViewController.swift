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
    
    var stats: Stats?
    var countDataTotal: [String] = []
    var countDataRecovered: [String] = []
    var countDataDead: [String] = []
    var settings:UIBarButtonItem = UIBarButtonItem()
    
    let favoritesButtonIcon = UIImage(named: "Star")
    let favoritesButtonIconFilled = UIImage(named: "StarFilled")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryLabel.text = stats?.country
        let buttonIcon = UIImage(named: "Settings")
        
        settings = UIBarButtonItem.init(title: "Settings", style: .plain, target: self, action: #selector(openSettings))
        settings.image = buttonIcon
        
        if stats?.favorite ?? false{
            favoritesButtonOutlet.setImage(favoritesButtonIconFilled, for: .normal)
        }else{
            favoritesButtonOutlet.setImage(favoritesButtonIcon, for: .normal)
        }
        navigationItem.title = "Details"
        navigationItem.rightBarButtonItems = [settings]
        showData()

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
    
    }
    
    @IBAction func favoritesButtonAction(_ sender: Any) {
        
        var favorites: [String] = UserDefaults.standard.stringArray(forKey: "Favorites") ?? []
        
        if stats?.favorite ?? false{
            favoritesButtonOutlet.setImage(favoritesButtonIcon, for: .normal)
            //remove from favorites
            if let index = favorites.firstIndex(of: stats!.country) {
                favorites.remove(at: index)
            }
        }else{
            favoritesButtonOutlet.setImage(favoritesButtonIconFilled, for: .normal)
            //add to favorites
            favorites.append(stats!.country)
            stats?.favorite = true
        }
        UserDefaults.standard.set(favorites, forKey: "Favorites")
    }
    
    @objc func openSettings(){
        let settingsViewController = storyboard?.instantiateViewController(identifier: "SettingsViewController") as! SettingsViewController
        navigationController?.pushViewController(settingsViewController, animated: true)
    }
}
