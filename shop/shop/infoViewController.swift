//
//  infoViewController.swift
//  shop
//
//  Created by Admin on 4/28/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class infoViewController: UIViewController {

    @IBOutlet weak var productsList: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var netMass: UILabel!
    
    var productListArray = [String]()
    var total = 0
    var mass = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        if productListArray.count == 0 {
            productsList.text = "No products yet"
        } else {
            productsList.text = ""
        }
        
        for (index, item) in productListArray.enumerated() {
            if index == productListArray.count - 1 {
                productsList.text! += "\(item)"
            } else {
                productsList.text! += "\(item), "
            }
        }
        
        totalPrice.text = ("$\(total)")
        netMass.text = ("\(mass) KG")
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
