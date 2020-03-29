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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func testSwitch(_ sender: Any) {
        if testSwitchOutlet.isOn{
            print("Switch was turned on")
        } else {
            print("Switch was turned off")
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

}
