//
//  SignUpVC.swift
//  social-app
//
//  Created by Admin on 5/6/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {

    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var repeatPasswordField: UITextField!
    
    @IBOutlet weak var signUpBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        userNameField.layer.cornerRadius = 25
        userNameField.setLeftPaddingPoints(25)
        userNameField.setRightPaddingPoints(25)
        passwordField.layer.cornerRadius = 25
        passwordField.setLeftPaddingPoints(25)
        passwordField.setRightPaddingPoints(25)
        emailField.layer.cornerRadius = 25
        emailField.setLeftPaddingPoints(25)
        emailField.setRightPaddingPoints(25)
        repeatPasswordField.layer.cornerRadius = 25
        repeatPasswordField.setLeftPaddingPoints(25)
        repeatPasswordField.setRightPaddingPoints(25)
        
        signUpBtn.layer.cornerRadius = 25
        
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    @IBAction func onSignUp(_ sender: UIButton) {
        
        if userNameField.text == "" || emailField.text == "" || passwordField.text == "" || repeatPasswordField.text == "" {
            showAlert(title: "Error", message: "Please, fill all fields.")
        } else if !emailField.text!.contains("@") {
            showAlert(title: "Error", message: "Please, enter valid email.")
        } else if passwordField.text != repeatPasswordField.text {
            showAlert(title: "Error", message: "Passwords don't match!")
        } else {
            UDStandard.setUserName(userNameField.text!)
            UDStandard.setEmail(emailField.text!)
            UDStandard.setPassword(passwordField.text!)
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}
