//
//  filterPodcastsViewController.swift
//  podcasts
//
//  Created by Admin on 5/13/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

protocol filterPodcasts {
    func updateFilterPodcasts(length: Int16)
    func saveSelected(min: Int, sec: Int)
}

class filterPodcastsViewController: UIViewController {

    @IBOutlet weak var lengthPicker: UIPickerView!
    
    var filterPodcastsDelegate: filterPodcasts?
    
    let pickerData = [
        Array(0...59),
        Array(0...59)
    ]
    
    var selectedMin: Int?
    var selectedSec: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        lengthPicker.delegate = self
        lengthPicker.dataSource = self
        
        lengthPicker.selectRow(selectedMin ?? 0, inComponent: 0, animated: true)
        lengthPicker.selectRow(selectedSec ?? 0, inComponent: 1, animated: true)
    }
    
    @IBAction func onFilter(_ sender: UIButton) {
        let lengthTime = Int16((lengthPicker.selectedRow(inComponent: 0))*60 + (lengthPicker.selectedRow(inComponent: 1)))
        
        filterPodcastsDelegate?.updateFilterPodcasts(length: lengthTime)
        filterPodcastsDelegate?.saveSelected(min: selectedMin ?? 0, sec: selectedSec ?? 0)
        self.dismiss(animated: true, completion: nil)
    }

}

extension filterPodcastsViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            selectedMin = pickerData[0][row]
        } else if component == 1 {
            selectedSec = pickerData[1][row]
        }
    }
}

extension filterPodcastsViewController: UIPickerViewDataSource {
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
