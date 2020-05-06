//
//  mainPageVC.swift
//  social-app
//
//  Created by Admin on 5/6/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class mainPageVC: UIViewController {
    
    
    @IBOutlet weak var messageField: UITextView!
    
    
    @IBOutlet weak var greenBG: UIView!
    @IBOutlet weak var pinkBG: UIView!
    @IBOutlet weak var blueBG: UIView!
    @IBOutlet weak var yellowBG: UIView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var logOutBtn: UIButton!
    
    override func loadView() {
        super.loadView()
        self.navigationItem.hidesBackButton = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        messageField.layer.cornerRadius = 25
        saveBtn.layer.cornerRadius = 25
        logOutBtn.layer.cornerRadius = 25
        messageField.textContainerInset = UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)
        
        greenBG.layer.cornerRadius = 25
        pinkBG.layer.cornerRadius = 25
        blueBG.layer.cornerRadius = 25
        yellowBG.layer.cornerRadius = 25
        
        greenBG.layer.borderWidth = 2
        greenBG.layer.borderColor = CGColor(srgbRed: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        pinkBG.layer.borderWidth = 2
        pinkBG.layer.borderColor = CGColor(srgbRed: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        blueBG.layer.borderWidth = 2
        blueBG.layer.borderColor = CGColor(srgbRed: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        yellowBG.layer.borderWidth = 2
        yellowBG.layer.borderColor = CGColor(srgbRed: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        
        greenBG.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(setBgGreen)))
        pinkBG.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(setBgPink)))
        blueBG.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(setBgBlue)))
        yellowBG.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(setBgYellow)))
        
        switch UDStandard.getBg() {
            case "green":
                view.backgroundColor = .systemGreen
            case "pink":
                view.backgroundColor = .systemPink
            case "blue":
                view.backgroundColor = .systemBlue
            case "yellow":
                view.backgroundColor = .systemYellow
            default:
                view.backgroundColor = .white
        }
        
        messageField.text = UDStandard.getMessage()

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    
    @IBAction func saveMessage(_ sender: UIButton) {
        UDStandard.setMessage(messageField.text)
        showAlert(title: "Success", message: "Message saved.")
    }
    
    @objc func setBgGreen() {
        view.backgroundColor = .systemGreen
        UDStandard.setBG("green")
    }
    
    @objc func setBgPink() {
        view.backgroundColor = .systemPink
        UDStandard.setBG("pink")
    }
    
    @objc func setBgBlue() {
        view.backgroundColor = .systemBlue
        UDStandard.setBG("blue")
    }
    
    @objc func setBgYellow() {
        view.backgroundColor = .systemYellow
        UDStandard.setBG("yellow")
    }
    
    @IBAction func onLogOut(_ sender: UIButton) {
        UDStandard.setSignedIn(false)
        self.navigationController?.popViewController(animated: true)
    }
    

}

