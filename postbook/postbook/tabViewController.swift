//
//  tabViewController.swift
//  postbook
//
//  Created by Admin on 5/15/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit
import CoreData

protocol updateTable {
    func updatePosts()
}

class tabViewController: UITabBarController, addPost {
  
    var updateTableDelegate: updateTable?
    
    var currentUser: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.hidesBackButton = true
    }
    
    @IBAction func onAddButton(_ sender: Any) {
        performSegue(withIdentifier: "add_post_segue", sender: homePageViewController.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "add_post_segue" {
            if let addPostVC = segue.destination as? addPostViewController {
                addPostVC.addPostDelegate = self
            }
        }
    }
    
    func newPost(content: String) {
        addNewPost(text: content)
        updateTableDelegate?.updatePosts()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        updateTableDelegate?.updatePosts()
    }

}
extension tabViewController {
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
    func addNewPost(text: String) {
        
        let context = AppDelegate.coreDataContainer.viewContext
        let entityDescriptionNote = NSEntityDescription.entity(forEntityName: "Post", in: context)
        
        var user: User?
        
        for userMatch in fetchUsers() {
            if userMatch.username == currentUser! {
                user = userMatch
            }
        }
        
        let post = Post(entity: entityDescriptionNote!, insertInto: context)
        
        post.content = text
        post.author = user
        post.date = Date()

        do {
            try context.save()
        } catch {
            
        }
    }

}
