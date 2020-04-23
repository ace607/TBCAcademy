//
//  ViewController.swift
//  tbc-app
//
//  Created by Admin on 4/23/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onButton(_ sender: UIButton) {
        myLabel.text = "text"
    }
    
}

