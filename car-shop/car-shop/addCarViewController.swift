//
//  addCarViewController.swift
//  car-shop
//
//  Created by Admin on 5/1/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

protocol addCarProtocol {
    func addCarObject(car: Car)
}

class addCarViewController: UIViewController {

    @IBOutlet weak var carImagesTable: UITableView!
    
    let carImages = ["camry", "bmw", "mercedes", "audi"]
    
    var selectedImageIndex = -1
    
    var addCarProtocolObj: addCarProtocol?
    
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        carImagesTable.delegate = self
        carImagesTable.dataSource = self
        
        
        modelTextField.setLeftPaddingPoints(25)
        modelTextField.setRightPaddingPoints(25)
        modelTextField.layer.cornerRadius = 25
        yearTextField.setLeftPaddingPoints(25)
        yearTextField.setRightPaddingPoints(25)
        yearTextField.layer.cornerRadius = 25
        priceTextField.setLeftPaddingPoints(25)
        priceTextField.setRightPaddingPoints(25)
        priceTextField.layer.cornerRadius = 25
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    @IBAction func addCarBtn(_ sender: UIButton) {
        if selectedImageIndex == -1 {
            showAlert(title: "Error", message: "Please, select an image.")
        } else if modelTextField.text == "" || yearTextField.text == "" || priceTextField.text == "" {
            showAlert(title: "Error", message: "Please, fill all fields.")
        } else if Int(yearTextField.text!) == nil || Int(priceTextField.text!) == nil {
            showAlert(title: "Error", message: "Year and price should be integers.")
        } else {
            let newCar = Car(model: modelTextField.text!, year: Int(yearTextField.text!), price: Int(priceTextField.text!), image: carImages[selectedImageIndex])
            addCarProtocolObj?.addCarObject(car: newCar)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}


extension addCarViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "add_car_cell", for: indexPath) as! addCarTableViewCell
        
        cell.imageListItem.image = UIImage(named: carImages[indexPath.row])
        
        
        return cell
    }
    
    
}

extension addCarViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedImageIndex = indexPath.row
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
