//
//  ViewController.swift
//  registration2
//
//  Created by Admin on 4/29/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var genderSegment: UISegmentedControl!
    @IBOutlet weak var registerButton: UIButton!
    
    var users = [user]()
    
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
        ageField.setLeftPaddingPoints(25)
        ageField.setRightPaddingPoints(25)
        ageField.layer.cornerRadius = 25
        phoneField.setLeftPaddingPoints(25)
        phoneField.setRightPaddingPoints(25)
        phoneField.layer.cornerRadius = 25
        registerButton.layer.cornerRadius = 25
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }

    @IBAction func register(_ sender: Any) {
        if firstNameField.text == "" || lastNameField.text == "" || emailField.text == "" || ageField.text == "" || phoneField.text == "" {
            showAlert(title: "Error", message: "Please, fill all fields.")
        } else if !emailField.text!.contains("@") {
            showAlert(title: "Error", message: "Please, enter valid email.")
        } else if Int(ageField.text!) == nil {
            showAlert(title: "Error", message: "Age must be an integer!!!.")
        } else if Int(phoneField.text!) == nil {
            showAlert(title: "Error", message: "Please, enter valid phone number.")
        } else {
            let newUser = user(firstName: firstNameField.text!, lastName: lastNameField.text!, email: emailField.text!, age: Int(ageField.text!)!, phone: Int(phoneField.text!)!, gender: genderSegment.selectedSegmentIndex == 0 ? "Male" : "Female")
            users.append(newUser)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            
            if identifier == "user_list_page" {
                if let userListVC = segue.destination as? userListViewController {
                    userListVC.tableSize = users.count
                    
                    userListVC.users = users
                }
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
