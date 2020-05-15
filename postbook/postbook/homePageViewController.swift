//
//  homePageViewController.swift
//  postbook
//
//  Created by Admin on 5/15/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit
import CoreData

protocol updateUser {
    func update()
}

class homePageViewController: UIViewController, updateTable {

    

    @IBOutlet weak var postTable: UITableView!
    
    var updateUserDelegate: updateUser?
    
    var currentUser: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        postTable.delegate = self
        postTable.dataSource = self
        
        
        if let tabController = self.tabBarController as? tabViewController {
            tabController.updateTableDelegate = self
        }
        
    }
       func updatePosts() {
           postTable.reloadData()
        updateUserDelegate?.update()
       }

}

extension homePageViewController: UITableViewDelegate {
    
}

extension homePageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getPosts().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = postTable.dequeueReusableCell(withIdentifier: "post_cell", for: indexPath) as! postTableViewCell
        
        cell.userImage = UIImage(data: (getPosts()[indexPath.row].author?.image)!)

        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        cell.postAuthor = "\(getPosts()[indexPath.row].author!.firstname!.capitalized) \(getPosts()[indexPath.row].author!.lastname!.capitalized)"
        cell.postCreationDate = formatter.string(from: getPosts()[indexPath.row].date!)
        cell.postText = getPosts()[indexPath.row].content
        return cell
        
    }
    
    
}

extension homePageViewController {

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
    func getPosts() -> [Post] {
        
        let context = AppDelegate.coreDataContainer.viewContext
        
        let request: NSFetchRequest<Post> = Post.fetchRequest()
        
        do {
            let result = try context.fetch(request)
            
            let posts = result as [Post]
            
            return posts.sorted(by: { ($0.date!).compare($1.date!) == .orderedDescending })
        } catch {
            print("ERROR: Couldn't fetch podcasts")
        }
        
        return []
    }

}
