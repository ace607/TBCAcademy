//
//  ViewController.swift
//  registration
//
//  Created by Admin on 4/27/20.
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

    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var numberField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var repeatPasswordField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        firstNameField.setLeftPaddingPoints(25)
        firstNameField.setRightPaddingPoints(25)
        firstNameField.layer.cornerRadius = 25
        lastNameField.setLeftPaddingPoints(25)
        lastNameField.setRightPaddingPoints(25)
        lastNameField.layer.cornerRadius = 25
        emailField.setLeftPaddingPoints(25)
        emailField.setRightPaddingPoints(25)
        emailField.layer.cornerRadius = 25
        numberField.setLeftPaddingPoints(25)
        numberField.setRightPaddingPoints(25)
        numberField.layer.cornerRadius = 25
        passwordField.setLeftPaddingPoints(25)
        passwordField.setRightPaddingPoints(25)
        passwordField.layer.cornerRadius = 25
        repeatPasswordField.setLeftPaddingPoints(25)
        repeatPasswordField.setRightPaddingPoints(25)
        repeatPasswordField.layer.cornerRadius = 25
        registerButton.layer.cornerRadius = 25
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func register(_ sender: UIButton) {
        if (firstNameField.text == "" || lastNameField.text == "" || emailField.text == "" || numberField.text == "" || passwordField.text == "" || repeatPasswordField.text == "" ) {
            showAlert(title: "Error", message: "Please, fill all fields.")
        } else if !emailField.text!.contains("@") {
            showAlert(title: "Error", message: "Please, enter valid e-mail address.")
        } else if Int(numberField.text!) == nil {
            showAlert(title: "Error", message: "Please, enter valid phone number.")
        } else if (passwordField.text!.count < 8 ) {
            showAlert(title: "Error", message: "Password must contain minimum 8 characters!!!")
        } else if (passwordField.text != repeatPasswordField.text) {
            showAlert(title: "Error", message: "Passwords don't match!!!")
        } else {
            performSegue(withIdentifier: "infoView", sender: sender)
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let showInfo = segue.destination as? InfoViewController {
            showInfo.firstNameText = firstNameField.text!
            showInfo.lastNameText = lastNameField.text!
            showInfo.emailText = emailField.text!
            showInfo.phoneText = numberField.text!
        }
    }
    

}

