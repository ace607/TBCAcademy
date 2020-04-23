//
//  ViewController.swift
//  tbc-app
//
//  Created by Admin on 4/23/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstInteger: UITextField!
    @IBOutlet weak var secondInteger: UITextField!
    @IBOutlet weak var result: UILabel!
    var selectedOperation = "+"
    @IBOutlet weak var fontSize: UILabel!
    
    @IBOutlet weak var calculateBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 94, green: 96, blue: 110, alpha: 1.0)], for: UIControl.State.normal)
        
        calculateBtn.layer.cornerRadius = 5

    }
    
    @IBAction func selectOperation(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                selectedOperation = "+"
            case 1:
                selectedOperation = "-"
            case 2:
                selectedOperation = "/"
            case 3:
                selectedOperation = "*"
            default:
                selectedOperation = "+"
        }
    }
    
    @IBAction func calculate(_ sender: UIButton) {
        if let firstValue = Int(firstInteger.text!), let secondValue = Int(secondInteger.text!) {
                switch selectedOperation {
                    case "+":
                        result.text = String(firstValue + secondValue)
                    case "-":
                        result.text = String(firstValue - secondValue)
                    case "/":
                        if secondValue != 0 {
                            result.text = String(firstValue / secondValue)
                        } else {
                            result.text = "Can't divide by zero"
                        }
                    case "*":
                        result.text = String(firstValue * secondValue)
                    default:
                        result.text = "result"
                }
        } else {
            result.text = "Enter numbers"
        }
    }
    
    @IBAction func changeSize(_ sender: UISlider) {
        let fixed = roundf(sender.value / 1);
        sender.setValue(fixed, animated: false)
        result.font = result.font.withSize(CGFloat(Int(sender.value)))
        fontSize.text = String(Int(sender.value))
    }
    
    
}
