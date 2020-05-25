//
//  ViewController.swift
//  prime-numbers
//
//  Created by Admin on 5/25/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var calcBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func printNumbers(_ sender: UIButton) {
        self.calcBtn.setTitle("Calculating...", for: .normal)
        self.calcBtn.layer.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.6).cgColor
        self.calcBtn.isUserInteractionEnabled = false
        DispatchQueue.global(qos: .background).async {
            
            for num in 1...100000 {
                
                if num == 2 || num == 3 || (num > 1 && !(2...Int(sqrt(Double(num)))).contains { num % $0 == 0 }) {
                    print(num)
                }
            }
            
            DispatchQueue.main.async {
                self.calcBtn.setTitle("Calculate Prime Numbers", for: .normal)
                self.calcBtn.layer.backgroundColor = UIColor.systemIndigo.cgColor
                self.calcBtn.isUserInteractionEnabled = true
            }
        }

    }
    

}

