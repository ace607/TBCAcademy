//
//  InfoViewController.swift
//  registration
//
//  Created by Admin on 4/27/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    var firstNameText: String?
    var lastNameText: String?
    var emailText: String?
    var phoneText: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        firstName.text = firstNameText
        lastName.text = lastNameText
        email.text = emailText
        phone.text = phoneText
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
