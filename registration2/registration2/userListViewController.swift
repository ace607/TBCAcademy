//
//  userListViewController.swift
//  registration2
//
//  Created by Admin on 4/29/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class userListViewController: UIViewController {

    @IBOutlet weak var userListTable: UITableView!
    
    var tableSize = 0
    
    var users = [user]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        userListTable.delegate = self
        userListTable.dataSource = self

    }
    

}

extension userListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableSize
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "user_cell", for: indexPath) as! userTableViewCell
        
        cell.fullNameLabel.text = "\(users[indexPath.row].firstName.capitalized)  \(users[indexPath.row].lastName.capitalized)"
        cell.genderLabel.text = users[indexPath.row].gender
        cell.ageLabel.text = String(users[indexPath.row].age)
        cell.emailLabel.text = users[indexPath.row].email
        cell.phoneLabel.text = String(users[indexPath.row].phone)
        
        return cell
    }
    
    
}
