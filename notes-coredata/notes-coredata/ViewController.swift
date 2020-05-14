//
//  ViewController.swift
//  notes-coredata
//
//  Created by Admin on 5/14/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var currentUser: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if UDManager.getUserLogged() {
            currentUser = UDManager.getCurrentUser()
            performSegue(withIdentifier: "notes_page_segue", sender: nil)
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
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
                performSegue(withIdentifier: "notes_page_segue", sender: nil)
            } else {
                showAlert(title: "Error", message: "Incorect credentials.")
            }

        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "notes_page_segue" {
            if let notesVC = segue.destination as? notesViewController {
                notesVC.currentUser = currentUser
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

