//
//  editNoteViewController.swift
//  notes
//
//  Created by Admin on 5/8/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

protocol editNote {
    func sendEdited(text: String, row: Int)
}

class editNoteViewController: UIViewController {
    
    var editNoteDelegate: editNote?

    @IBOutlet weak var editNoteText: UITextView!
    
    var editNoteTextContent: String?
    
    var editingRow: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        editNoteText.text = editNoteTextContent
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    @IBAction func onSave(_ sender: UIButton) {
        let text = editNoteText.text ?? ""
        if text == "" {
            showAlert(title: "Error", message: "Please, enter some text.")
        } else {
            editNoteDelegate?.sendEdited(text: text, row: editingRow!)
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
