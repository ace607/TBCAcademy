//
//  SignInViewController.swift
//  TheCocktailDB
//
//  Created by Admin on 5/23/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit
import CoreData

protocol SignIn {
    func signIn()
}

class SignInViewController: UIViewController {
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signInBtn: UIButton!
    
    var signInDelegate: SignIn?
    
    let cd = CDServices()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameField.setLeftPaddingPoints(25)
        userNameField.setRightPaddingPoints(25)
        passwordField.setLeftPaddingPoints(25)
        passwordField.setRightPaddingPoints(25)
        
        userNameField.layer.cornerRadius = 25
        passwordField.layer.cornerRadius = 25
        signInBtn.layer.cornerRadius = 25
    }
    
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }

    @IBAction func onSignIn(_ sender: UIButton) {
        
        if userNameField.text == "" || passwordField.text == "" {
            showAlert(title: "Error", message: "Please, fill all fields.")
        } else if cd.fetchUsers().count == 0 {
            showAlert(title: "Error", message: "Please register a user.")
        } else {
            var userFound = false
            for user in cd.fetchUsers() {
                if user.username == userNameField.text && user.password == passwordField.text {
                    userFound = true
                }
            }
            if userFound {
                UDManager.setSigned(value: true)
                UDManager.setUser(value: userNameField.text!)
                self.signInDelegate?.signIn()
                self.dismiss(animated: true, completion: nil)
            } else {
                showAlert(title: "Error", message: "Incorect credentials.")
            }

        }
    }
    
}


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

