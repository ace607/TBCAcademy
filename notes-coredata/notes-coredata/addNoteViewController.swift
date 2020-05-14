//
//  addNoteViewController.swift
//  notes-coredata
//
//  Created by Admin on 5/15/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

protocol addNote {
    func addNewNote(content: String)
}

class addNoteViewController: UIViewController {
    
    var addNoteDelegate: addNote?

    @IBOutlet weak var noteContentField: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    @IBAction func onNoteAdd(_ sender: UIButton) {
        if noteContentField.text == "" {
            showAlert(title: "Error", message: "Please, enter note content.")
        } else {
            addNoteDelegate?.addNewNote(content: noteContentField.text)
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
