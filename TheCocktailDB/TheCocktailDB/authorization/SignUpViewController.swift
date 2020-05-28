//
//  SignUpViewController.swift
//  TheCocktailDB
//
//  Created by Admin on 5/23/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit
import CoreData

class SignUpViewController: UIViewController {
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var repeatPasswordField: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    
    let cd = CDServices()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        userNameField.setLeftPaddingPoints(25)
        userNameField.setRightPaddingPoints(25)
        firstNameField.setLeftPaddingPoints(25)
        firstNameField.setRightPaddingPoints(25)
        lastNameField.setLeftPaddingPoints(25)
        lastNameField.setRightPaddingPoints(25)
        emailField.setLeftPaddingPoints(25)
        emailField.setRightPaddingPoints(25)
        passwordField.setLeftPaddingPoints(25)
        passwordField.setRightPaddingPoints(25)
        repeatPasswordField.setLeftPaddingPoints(25)
        repeatPasswordField.setRightPaddingPoints(25)
        
        userNameField.layer.cornerRadius = 25
        firstNameField.layer.cornerRadius = 25
        lastNameField.layer.cornerRadius = 25
        emailField.layer.cornerRadius = 25
        passwordField.layer.cornerRadius = 25
        repeatPasswordField.layer.cornerRadius = 25
        
        signUpBtn.layer.cornerRadius = 25
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    @IBAction func onSignUp(_ sender: UIButton) {
        if userNameField.text == "" || firstNameField.text == "" || lastNameField.text == "" || emailField.text == "" || passwordField.text == "" || repeatPasswordField.text == ""  {
            showAlert(title: "Error", message: "Please, fill all fields.")
        } else if !emailField.text!.contains("@") {
            showAlert(title: "Error", message: "Please, enter valid e-mail address.")
        } else if passwordField.text != repeatPasswordField.text {
            showAlert(title: "Error", message: "Passwords don't match!!")
        } else {
            var userCanRegister = true
            for user in cd.fetchUsers() {
                if user.username == userNameField.text || user.email == emailField.text {
                    showAlert(title: "Error", message: "User with this credentials already exists!!")
                    userCanRegister = false
                }
            }
            
            if userCanRegister {
                cd.addUser(username: userNameField.text!, firstname: firstNameField.text!, lastname: lastNameField.text!, email: emailField.text!, password: passwordField.text!)
                self.dismiss(animated: true, completion: nil)
            }
            
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
