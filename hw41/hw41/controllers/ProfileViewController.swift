//
//  ProfileViewController.swift
//  hw41
//
//  Created by Admin on 6/16/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit
import Localize

class ProfileViewController: UIViewController {

    @IBOutlet weak var langSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if Localize.currentLanguage == "ge" {
            langSwitch.setOn(true, animated: false)
        } else {
            langSwitch.setOn(false, animated: false)

        }
    }
    
    @IBAction func switchToGe(_ sender: UISwitch) {
        if langSwitch.isOn {
            Localize.update(language: "ge")
        } else {
            Localize.update(language: "en")
        }
        NotificationCenter.default.post(name: NSNotification.Name("update_orders"), object: nil)
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
