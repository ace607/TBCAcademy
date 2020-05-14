//
//  signUpViewController.swift
//  notes-coredata
//
//  Created by Admin on 5/14/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit
import CoreData

class signUpViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var repeatPasswordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    @IBAction func onSignUp(_ sender: UIButton) {
        if usernameField.text == "" || emailField.text == "" || ageField.text == "" || passwordField.text == "" || repeatPasswordField.text == "" {
            showAlert(title: "Error", message: "Please, fill all fields.")
        } else if !emailField.text!.contains("@") {
            showAlert(title: "Error", message: "Please, enter valid e-mail address.")
        } else if Int(ageField.text!) == nil {
            showAlert(title: "Error", message: "Age must be an integer!!")
        } else if passwordField.text != repeatPasswordField.text {
            showAlert(title: "Error", message: "Passwords don't match!!")
        } else {
            addUser(username: usernameField.text!, email: emailField.text!, age: Int16(ageField.text!)!, password: passwordField.text!)
            self.navigationController?.popViewController(animated: true)
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

extension signUpViewController {
    func addUser(username: String, email: String, age: Int16, password: String) {
        
        let context = AppDelegate.coreDataContainer.viewContext
        let entityDescription = NSEntityDescription.entity(forEntityName: "User", in: context)
        
        let user = User(entity: entityDescription!, insertInto: context)
        
        user.username = username
        user.email = email
        user.age = age
        user.password = password

        do {
            try context.save()
        } catch {
            
        }
        
    }
}
