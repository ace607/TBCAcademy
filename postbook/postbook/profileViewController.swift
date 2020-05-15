//
//  profileViewController.swift
//  postbook
//
//  Created by Admin on 5/15/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit
import CoreData

class profileViewController: UIViewController, updateUser {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var age: UILabel!
    
    var currentUser: String?
    var userEmail: String?
    var userAge: Int?
    var userFullName: String?
    var userImage1: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let tabController = self.tabBarController as? tabViewController {
            currentUser = tabController.currentUser
            
            for user in fetchUsers() {
                if user.username == currentUser {
                    userEmail = user.email
                    userAge = Int(user.age)
                    userFullName = "\(user.firstname!.capitalized) \(user.lastname!.capitalized)"
                    userImage1 = UIImage(data: user.image!)
                }
            }
        }
        
        userImage.image = userImage1
        fullName.text = userFullName
        username.text = currentUser
        email.text = userEmail
        age.text = String(userAge!)
        
        userImage.layer.cornerRadius = 50
        
        
    }
    
    func update() {
            for user in fetchUsers() {
                if user.username == currentUser {
                    userEmail = user.email
                    userAge = Int(user.age)
                    userFullName = "\(user.firstname!.capitalized) \(user.lastname!.capitalized)"
                    userImage1 = UIImage(data: user.image!)
                }
            }
        
        userImage.image = userImage1
        fullName.text = userFullName
        username.text = currentUser
        email.text = userEmail
        age.text = String(userAge!)
        
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

extension profileViewController {
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
