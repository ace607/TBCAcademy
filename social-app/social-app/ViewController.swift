//
//  ViewController.swift
//  social-app
//
//  Created by Admin on 5/6/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var signInBtn: UIButton!
    
    @IBOutlet weak var signUpBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        userNameField.layer.cornerRadius = 25
        userNameField.setLeftPaddingPoints(25)
        userNameField.setRightPaddingPoints(25)
        passwordField.layer.cornerRadius = 25
        passwordField.setLeftPaddingPoints(25)
        passwordField.setRightPaddingPoints(25)
        
        signInBtn.layer.cornerRadius = 25
        signUpBtn.layer.cornerRadius = 25
        
        if UDStandard.isSignedIn() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainVC = storyboard.instantiateViewController(withIdentifier: "mainVC")
            self.navigationController?.pushViewController(mainVC, animated: true)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    @IBAction func onSignIn(_ sender: UIButton) {
        if userNameField.text == "" || passwordField.text == "" {
            showAlert(title: "Error", message: "Please, enter username and password.")
        } else if userNameField.text != UDStandard.getUserName() || passwordField.text != UDStandard.getPassword() {
            showAlert(title: "Error", message: "Incorrect username or password!")
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainVC = storyboard.instantiateViewController(withIdentifier: "mainVC")
            self.navigationController?.pushViewController(mainVC, animated: true)
            UDStandard.setSignedIn(true)
        }
        
    }
    
    @IBAction func onSignUpBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signUpVC = storyboard.instantiateViewController(withIdentifier: "SIGNUPVC")
        self.navigationController?.pushViewController(signUpVC, animated: true)
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
