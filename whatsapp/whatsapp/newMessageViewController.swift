//
//  newMessageViewController.swift
//  whatsapp
//
//  Created by Admin on 5/7/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

protocol newMessage {
    func createNewMessage(item: chatItem)
}

class newMessageViewController: UIViewController {
    
    var createMessage: newMessage?
    
    let profileImages = ["profile-image-1", "profile-image-2", "profile-image-3", "profile-image-4"]

    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var messageTextField: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    @IBAction func onSend(_ sender: Any) {
        if numberTextField.text == "" || messageTextField.text == "" {
            showAlert(title: "Error", message: "Please, fill all fields.")
        } else if Int(numberTextField.text!) == nil {
            showAlert(title: "Error", message: "Number should be an integer.")
        } else {
            let newMessage = chatItem(image: UIImage(named: profileImages[Int.random(in: 0...3)])!, name: numberTextField.text!, message: messageTextField.text!)
            createMessage?.createNewMessage(item: newMessage)
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
