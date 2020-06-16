//
//  ViewController.swift
//  hw41
//
//  Created by Admin on 6/15/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var coffeeTable: UITableView!
    
    var coffeeList = [
        (name: "Espresso", img: "Espresso"),
        (name: "Cappuccino", img: "Cappuccino"),
        (name: "Macchiato", img: "macciato"),
        (name: "Mocha", img: "Mocha"),
        (name: "Latte", img: "latte")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        coffeeTable.delegate = self
        coffeeTable.dataSource = self
        coffeeTable.separatorStyle = .none
        
    }


}

extension HomeViewController: UITableViewDelegate {
    
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coffeeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = coffeeTable.dequeueReusableCell(withIdentifier: "coffee_cell", for: indexPath) as! CoffeeTableViewCell
        
        cell.img.image = UIImage(named: coffeeList[indexPath.row].img)
        cell.name.text = coffeeList[indexPath.row].name
        cell.backgroundColor = UIColor.clear
        
        
        return cell
    }
    
    
}

