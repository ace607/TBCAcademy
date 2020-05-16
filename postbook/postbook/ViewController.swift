//
//  ViewController.swift
//  postbook
//
//  Created by Admin on 5/15/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var currentUser: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if UDManager.getUserLogged() {
            currentUser = UDManager.getCurrentUser()
            performSegue(withIdentifier: "home_page_segue", sender: nil)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }

    }

    @objc func keyboardWillHide(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
    
    @IBAction func onSignIn(_ sender: UIButton) {
        if usernameField.text == "" || passwordField.text == "" {
            showAlert(title: "Error", message: "Please, fill all fields.")
        } else if fetchUsers().count == 0 {
            showAlert(title: "Error", message: "Please register a user.")
        } else {
            var userFound = false
            for user in fetchUsers() {
                if user.username == usernameField.text && user.password == passwordField.text {
                    userFound = true
                    currentUser = user.username
                }
            }
            if userFound {
                usernameField.text = ""
                passwordField.text = ""
                UDManager.changeUserLogged(true)
                UDManager.setCurrentUser(currentUser!)
                performSegue(withIdentifier: "home_page_segue", sender: nil)
            } else {
                showAlert(title: "Error", message: "Incorect credentials.")
            }

        }
        
    }
    
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    @IBAction func onSignUpPage(_ sender: Any) {
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "home_page_segue" {
            if let tabVC = segue.destination as? tabViewController {
                tabVC.currentUser = currentUser
            }
        }
    }
    
}

extension ViewController {
    
    func fetchUsers() -> [User] {
        let context = AppDelegate.coreDataContainer.viewContext
        
        let request: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let result = try context.fetch(request)
            
            let users = result as [User]
            
            return users
        } catch {
            print("ERROR: Couldn't fetch podcasts")
        }
        
        return []
    }
}
