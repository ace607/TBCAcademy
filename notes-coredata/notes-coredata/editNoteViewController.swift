//
//  editNoteViewController.swift
//  notes-coredata
//
//  Created by Admin on 5/15/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

protocol editNote {
    func editNoteFunc(newText: String)
}

class editNoteViewController: UIViewController {

    var editNoteDelegate: editNote?
    
    var editingText: String?
    
    @IBOutlet weak var editNoteField: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        editNoteField.text = editingText
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    @IBAction func onNoteSave(_ sender: UIButton) {
        if editNoteField.text == "" {
            showAlert(title: "Error", message: "Note must contain some text!")
        } else {
            editNoteDelegate?.editNoteFunc(newText: editNoteField.text)
            self.navigationController?.popViewController(animated: true)
        }
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
