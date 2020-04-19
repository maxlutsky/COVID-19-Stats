//
//  SettingsViewController.swift
//  COVID-19 Stats
//
//  Created by Max on 29/03/2020.
//  Copyright © 2020 Max. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var testSwitchOutlet: UISwitch!
    @IBOutlet weak var removeButtonOutlet: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Settings"
        testSwitchOutlet.isOn = UserDefaults.standard.bool(forKey: "testSwitch")
        removeButtonOutlet.setBackgroundImage(UIImage(named: "settings.pdf"), for: UIControl.State.normal)
    }
    
    
    @IBAction func testSwitch(_ sender: Any) {
        if testSwitchOutlet.isOn{
            UserDefaults.standard.set(true, forKey: "testSwitch")
        } else {
            UserDefaults.standard.set(false, forKey: "testSwitch")
        }
    }

    @IBAction func removeDataButtonAction(_ sender: Any) {
        
        let deletedAlert = UIAlertController(title: "Deleted", message: "", preferredStyle: .alert)
        
        deletedAlert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: { _ in
        }))
        let warningAlert = UIAlertController(title: "Are you sure that you want to remove all data?", message: "You will not be able to undo this. This action will remove all stored information.", preferredStyle: .alert)
        
        warningAlert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            self.present(deletedAlert, animated: true, completion: nil)
        }))
        warningAlert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .default, handler: { _ in
            NSLog("The \"Cancel\" alert occured.")
        }))
        
        self.present(warningAlert, animated: true, completion: nil)
        
    }
}
