//
//  settingsViewController.swift
//  postbook
//
//  Created by Admin on 5/15/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit
import CoreData

class settingsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var currentImage: UIImageView!
    @IBOutlet weak var currentName: UITextField!
    @IBOutlet weak var currentLastName: UITextField!
    @IBOutlet weak var currentEmail: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    
    
    var currentUser: String?
    var userEmail: String?
    var userAge: Int?
    var userFirstName: String?
    var userLastName: String?
    var userImage1: UIImage?
    var currentPassword: String?
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let tabController = self.tabBarController as? tabViewController {
            currentUser = tabController.currentUser
            
            
            for user in fetchUsers() {
                if user.username == currentUser {
                    userEmail = user.email
                    userAge = Int(user.age)
                    userFirstName = user.firstname
                    userLastName = user.lastname
                    userImage1 = UIImage(data: user.image!)
                    currentPassword = user.password
                }
            }
            
        }

        currentImage.image = userImage1
        currentName.text = userFirstName
        currentLastName.text = userLastName
        currentEmail.text = userEmail
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onImageViewTapped))
        currentImage.isUserInteractionEnabled = true
        currentImage.addGestureRecognizer(tapGesture)
    }
    
    
    @objc func onImageViewTapped() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    @IBAction func onSave(_ sender: UIButton) {
        if currentName.text == "" || currentLastName.text == "" || currentEmail.text == "" {
            showAlert(title: "Error", message: "Please, fill all fields.")
        } else if !currentEmail.text!.contains("@") {
            showAlert(title: "Error", message: "Invalid e-mail!!")
        } else if newPassword.text == "" {
            editUser(firstname: currentName.text!, lastname: currentLastName.text!, email: currentEmail.text!, password: currentPassword!, image: currentImage.image!)
        } else {
            editUser(firstname: currentName.text!, lastname: currentLastName.text!, email: currentEmail.text!, password: newPassword.text!, image: currentImage.image!)
        }
    }
    
    @IBAction func onLogOut(_ sender: UIButton) {
        
        UDManager.changeUserLogged(false)
        self.navigationController?.popViewController(animated: true)
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

extension settingsViewController {
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
    
    func editUser(firstname: String, lastname: String, email: String, password: String, image: UIImage) {
        
        let context = AppDelegate.coreDataContainer.viewContext
        
        do {
            for user in fetchUsers() {
                if user.username == currentUser {
                    user.firstname = firstname
                    user.lastname = lastname
                    user.email = email
                    user.password = password
                    user.image = image.pngData()
                }
            }
            try context.save()
        } catch {
            print("ERROR: Couldn't save info")
        }
        
    }
}
extension settingsViewController {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            self.currentImage.image = image
        }
        
        self.dismiss(animated: true)
    }
}
