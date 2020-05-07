//
//  callsViewController.swift
//  whatsapp
//
//  Created by Admin on 5/7/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class callsViewController: UIViewController {
    
    var callList = [callItem]()
        

    @IBOutlet weak var callsTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        callsTable.delegate = self
        callsTable.dataSource = self
        
        callList.append(callItem(number: 599412332, country: "Georgia", date: "Sunday"))
        callList.append(callItem(number: 0893196929, country: "France", date: "Sunday"))
        callList.append(callItem(number: 1886590403, country: "US", date: "Saturday"))
        callList.append(callItem(number: 577997878, country: "Georgia", date: "Thursday"))
        callList.append(callItem(number: 568210100, country: "Georgia", date: "4/28/20"))
    }

}

struct callItem {
    var number: Int
    var country: String
    var date: String
}

extension callsViewController: UITableViewDelegate {
    
}

extension callsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return callList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = callsTable.dequeueReusableCell(withIdentifier: "calls_cell", for: indexPath) as! callsTableViewCell
        
        cell.numberLabel.text = String(callList[indexPath.row].number)
        cell.countryLabel.text = callList[indexPath.row].country
        cell.dateLabel.text = callList[indexPath.row].date
        
        return cell
    }
    
    
}
