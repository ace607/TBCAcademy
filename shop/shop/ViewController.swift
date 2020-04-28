//
//  ViewController.swift
//  shop
//
//  Created by Admin on 4/28/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class product {
    var name: String?
    var price: Int?
    var category: String?
    
    init(name: String, price: Int, category: String) {
        self.name = name
        self.price = price
        self.category = category
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var productNumLabel: UILabel!
    
    @IBOutlet weak var productNameField: UITextField!
    @IBOutlet weak var productCountField: UITextField!
    @IBOutlet weak var productPriceField: UITextField!
    
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var calcBtn: UIButton!
    
    @IBOutlet weak var productCategorySegment: UISegmentedControl!
    
    
    var productCount = 0
    var products = [product]()
    
    var totalPrice = 0
    var masses = ["Vegetable": 5, "Fruit": 7, "Nut": 11, "Cereal": 3]
    var totalMass = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        productNameField.setLeftPaddingPoints(30)
        productNameField.setRightPaddingPoints(30)
        productNameField.layer.cornerRadius = 30
        productCountField.setLeftPaddingPoints(30)
        productCountField.setRightPaddingPoints(30)
        productCountField.layer.cornerRadius = 30
        productPriceField.setLeftPaddingPoints(30)
        productPriceField.setRightPaddingPoints(30)
        productPriceField.layer.cornerRadius = 30
        addBtn.layer.cornerRadius = 30
        calcBtn.layer.cornerRadius = 30
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }

    @IBAction func addProduct(_ sender: UIButton) {
        var productCategory = ""
        
        switch productCategorySegment.selectedSegmentIndex {
            case 0:
                productCategory = "Vegetable"
            case 1:
                productCategory = "Fruit"
            case 2:
                productCategory = "Nut"
            case 3:
                productCategory = "Cereal"
            default:
                productCategory = "Vegetable"
        }
        
        if productNameField.text == "" || productCountField.text == "" || productPriceField.text == "" {
            showAlert(title: "Error", message: "Please, fill all fields.")
        } else if Int(productCountField.text!) == nil {
            showAlert(title: "Error", message: "Count value should be an integer!!!")
        } else if Int(productPriceField.text!) == nil {
            showAlert(title: "Error", message: "Price value should be an integer!!!")
        } else {
            var count = Int(productCountField.text!)!
            
            while count != 0 {
                products.append(product(name: productNameField.text!, price: Int(productPriceField.text!)!, category: productCategory))
                productCount += 1
                productNumLabel.text = String(productCount)
                count -= 1
                
                totalMass += masses[productCategory]!
            }
            totalPrice += Int(productCountField.text!)! * Int(productPriceField.text!)!
        }
    }
    
    @IBAction func calculate(_ sender: UIButton) {
        performSegue(withIdentifier: "showInfo", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let info = segue.destination as? infoViewController {
            for item in products {
                info.productListArray.append(item.name!)
            }
            info.total = totalPrice
            info.mass = totalMass
        }
    }
    
}

