//
//  ViewController.swift
//  login
//
//  Created by Admin on 4/24/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginBTN: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        userName.setLeftPaddingPoints(25)
        userName.setRightPaddingPoints(25)
        userName.layer.cornerRadius = 30.0
        password.setLeftPaddingPoints(25)
        password.setRightPaddingPoints(25)
        password.layer.cornerRadius = 30
        loginBTN.layer.cornerRadius = 30
    }
    

    @IBAction func onSignIn(_ sender: UIButton) {
        if userName.text != "" && password.text != "" {
            let alert = UIAlertController(title: "Success", message: "Welcome to Google comrade \(userName.text!)!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Next", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Error", message: "Please type your username and password", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Retry", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
}

