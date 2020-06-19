//
//  CoffeeViewController.swift
//  hw41
//
//  Created by Admin on 6/16/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit
import Localize

class OrdersViewController: UIViewController {

    @IBOutlet weak var ordersTable: UITableView!
    
    var orders = [CoffeeOrder]()
    
    let orderViewModel = OrderViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ordersTable.delegate = self
        ordersTable.dataSource = self
        
        orders = orderViewModel.getOrders
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didRecieveOrder(with:)),
            name: NSNotification.Name("update_orders"),
            object: nil)
        ordersTable.reloadData()
    }
    
    
    @objc func didRecieveOrder(with notification: Notification) {
        
        orders = orderViewModel.getOrders
        self.ordersTable.reloadData()
        view.layoutIfNeeded()
        
    }
    
}

extension OrdersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ordersTable.dequeueReusableCell(withIdentifier: "order_cell", for: indexPath) as! OrderTableViewCell
        

        cell.name.text = orders[indexPath.row].name
        cell.size.text = orders[indexPath.row].size
        if Localize.currentLanguage == "ge" {
            if orders[indexPath.row].size == "Small" {
                cell.size.text = "პატარა"
            } else if orders[indexPath.row].size == "Medium" {
                cell.size.text = "საშუალო"
            } else if orders[indexPath.row].size == "Large" {
                cell.size.text = "დიდი"
            }
        }
        cell.sugar.text = Localize.currentLanguage == "ge" ? "შაქარი: \(orders[indexPath.row].sugar)" : "Sugar: \(orders[indexPath.row].sugar) cubes"
        cell.price.text = "$\(orders[indexPath.row].price)"
        
        return cell
    }
    
    
}
