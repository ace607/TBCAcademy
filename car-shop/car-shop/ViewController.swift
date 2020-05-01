//
//  ViewController.swift
//  car-shop
//
//  Created by Admin on 5/1/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, addCarProtocol {

    @IBOutlet weak var carTable: UITableView!
    
    var cars = [Car]()
    
    var scrollPosition = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        carTable.delegate = self
        carTable.dataSource = self
    }
    
    func scrollTop() {
        if carTable.numberOfRows(inSection: 0) > 0 {
            let indexPath = IndexPath(row: 0, section: 0)
            carTable.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    
    func scrollBottom() {
        if carTable.numberOfRows(inSection: 0) > 0 {
            let indexPath = IndexPath(row: (cars.count - 1), section: 0)
            carTable.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    @IBAction func scrollToTop(_ sender: UIButton) {
        scrollTop()
        scrollPosition = 0
    }
    
    @IBAction func scrollToBottom(_ sender: UIButton) {
        scrollBottom()
        scrollPosition = 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "add_car_segue" {
            if let addCarVC = segue.destination as? addCarViewController {
                addCarVC.addCarProtocolObj = self
            }
        }
    }

    func addCarObject(car: Car) {
        cars.append(car)
        carTable.reloadData()
        if self.scrollPosition == 0 {
            self.scrollTop()
        } else if self.scrollPosition == 1 {
            self.scrollBottom()
        }
    }
}

struct Car {
    var model: String?
    var year: Int?
    var price: Int?
    var image: String?
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "car_cell", for: indexPath) as! carTableViewCell
        
        let car = cars[indexPath.row]
        
        cell.carModel.text = car.model
        cell.carYear.text = String(car.year!)
        cell.carPrice.text = "$\(String(car.price!))"
        cell.carImage.image = UIImage(named: car.image!)
        
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
}
