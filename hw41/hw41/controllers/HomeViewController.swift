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
    
    var coffees = [Coffee]()
    
    let viewModel = CoffeeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        coffeeTable.delegate = self
        coffeeTable.dataSource = self
        coffeeTable.separatorStyle = .none
        
        coffees = viewModel.getCoffees
        
        
    }


}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "show_detail", sender: nil)
        
        let storyboard = UIStoryboard(name: "home", bundle: nil)
        
        let viewController = storyboard.instantiateViewController(identifier: "details_controller") as! DetailsViewController
        
        viewController.currentCoffee = coffees[indexPath.row]
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coffees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = coffeeTable.dequeueReusableCell(withIdentifier: "coffee_cell", for: indexPath) as! CoffeeTableViewCell
        
        cell.coffee = coffees[indexPath.row]
        
        
        return cell
    }
}
