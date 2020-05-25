//
//  ViewController.swift
//  TheCocktailDB
//
//  Created by Admin on 5/23/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SignIn {
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    
    var service = APIServices()
    var categoryList = [String]()
    var selectedCategories = Set<Int>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loginBtn.layer.cornerRadius = 25
        signUpBtn.layer.cornerRadius = 25
        
        if UDManager.getSigned() {
            self.performSegue(withIdentifier: "main_page_segue", sender: nil)
        }
        
        
        
    }
    

    @IBAction func showLogin(_ sender: UIButton) {
        performSegue(withIdentifier: "sign_in_segue", sender: nil)
    }
    
    @IBAction func showSignUp(_ sender: UIButton) {
        performSegue(withIdentifier: "sign_up_segue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "sign_in_segue" {
            if let destination = segue.destination as? SignInViewController {
                destination.signInDelegate = self
            }
        }
    }
    
    func signIn() {
        if UDManager.getSigned() {
            self.performSegue(withIdentifier: "main_page_segue", sender: nil)
        }
    }
    
}

