//
//  ViewController.swift
//  hw39-alert
//
//  Created by Admin on 6/11/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        showAlert()
    }

    func showAlert() {
        let alert = UIAlertController(title: " \n \n", message: "AAAAAAAAAAAA", preferredStyle: .alert)

        let img = UIImageView(frame: CGRect(x: 270/2 - 15, y: 20, width: 30, height: 30))
        img.image = UIImage(systemName: "info.circle.fill")
        alert.view.addSubview(img)
        alert.view.frame.inset(by: UIEdgeInsets(top: 90, left: 0, bottom: 0, right: 0))
        
        let closeAction = UIAlertAction(title: "kill alert", style: UIAlertAction.Style.cancel)
        
        alert.addAction(closeAction)
        
        self.present(alert, animated: true)
    }
}

