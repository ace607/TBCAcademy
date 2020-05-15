//
//  signUpViewController.swift
//  postbook
//
//  Created by Admin on 5/15/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit
import CoreData

class signUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var chooseImage: UIImageView!
    
    
    @IBOutlet weak var firstnameField: UITextField!
    @IBOutlet weak var lastnameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var repeatPasswordField: UITextField!
    
    let imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onImageViewTapped))
        chooseImage.isUserInteractionEnabled = true
        chooseImage.addGestureRecognizer(tapGesture)
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
    
    @IBAction func onSignUp(_ sender: UIButton) {
        if firstnameField.text == "" || lastnameField.text == "" || usernameField.text == "" || emailField.text == "" || ageField.text == "" || passwordField.text == "" || repeatPasswordField.text == "" {
            showAlert(title: "Error", message: "Please, fill all fields.")
        } else if !emailField.text!.contains("@") {
            showAlert(title: "Error", message: "Please, enter valid e-mail address.")
        } else if Int(ageField.text!) == nil {
            showAlert(title: "Error", message: "Age must be an integer!!")
        } else if passwordField.text != repeatPasswordField.text {
            showAlert(title: "Error", message: "Passwords don't match!!")
        } else {
            addUser(username: usernameField.text!, firstname: firstnameField.text!, lastname: lastnameField.text!, email: emailField.text!, age: Int16(ageField.text!)!, password: passwordField.text!, image: chooseImage)
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
    func addUser(username: String, firstname: String, lastname: String, email: String, age: Int16, password: String, image: UIImageView) {
        
        let context = AppDelegate.coreDataContainer.viewContext
        let entityDescription = NSEntityDescription.entity(forEntityName: "User", in: context)
        
        let user = User(entity: entityDescription!, insertInto: context)
        
        user.username = username
        user.email = email
        user.age = age
        user.password = password
        user.firstname = firstname
        user.lastname = lastname
        
        if let binaryImage = image.image?.pngData() {
            user.image = binaryImage
        }

        do {
            try context.save()
        } catch {
            
        }
        
    }
}

extension signUpViewController {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            self.chooseImage.image = image
        }
        
        self.dismiss(animated: true)
    }
}
