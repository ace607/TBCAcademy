//
//  addPodcastViewController.swift
//  podcasts
//
//  Created by Admin on 5/13/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit
protocol addPodcast {
    func addNewPodcast(title: String, desc: String, length: Int16)
}
class addPodcastViewController: UIViewController {
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descField: UITextView!
    @IBOutlet weak var lengthPicker: UIPickerView!
    var addPodcastDelegate: addPodcast?
    
    let pickerData = [
        Array(0...59),
        Array(0...59)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        lengthPicker.delegate = self
        lengthPicker.dataSource = self
        
        
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    @IBAction func onAdd(_ sender: UIButton) {
        if titleField.text == "" || descField.text == "" {
            showAlert(title: "Error", message: "Please, enter title and description.")
        } else {
            let lengthTime = Int16((lengthPicker.selectedRow(inComponent: 0))*60 + (lengthPicker.selectedRow(inComponent: 1)))
            addPodcastDelegate?.addNewPodcast(title: titleField.text!, desc: descField.text, length: lengthTime)
            self.navigationController?.popViewController(animated: true)
        }
    }

}

extension addPodcastViewController: UIPickerViewDelegate {
    
}

extension addPodcastViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(format: "%02d", pickerData[component][row])
    }
}
