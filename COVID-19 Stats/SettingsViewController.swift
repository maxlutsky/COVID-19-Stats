//
//  SettingsViewController.swift
//  COVID-19 Stats
//
//  Created by Max on 29/03/2020.
//  Copyright © 2020 Max. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

//    let dataService = DataService.shared
    
    @IBOutlet weak var testSwitchOutlet: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        testSwitchOutlet.isOn = UserDefaults.standard.bool(forKey: "testSwitch")
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func testSwitch(_ sender: Any) {
        if testSwitchOutlet.isOn{
            print("Switch was turned on")
            UserDefaults.standard.set(true, forKey: "testSwitch")
        } else {
            print("Switch was turned off")
            UserDefaults.standard.set(false, forKey: "testSwitch")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func removeDataButtonAction(_ sender: Any) {
        
        let alert = UIAlertController(title: "Are you sure that you want to remove all data?", message: "You will not be able to undo this. This action will remove all stored information.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
//            self.dataService.fetchAndDelete()
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .default, handler: { _ in
            NSLog("The \"Cancel\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
}
