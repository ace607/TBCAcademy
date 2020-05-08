//
//  addNoteViewController.swift
//  notes
//
//  Created by Admin on 5/8/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

protocol newNote {
    func addNewNote(text: String)
}

class addNoteViewController: UIViewController {
    
    var newNoteInstance: newNote?

    @IBOutlet weak var newNoteText: UITextView!
    @IBOutlet weak var addNoteButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    @IBAction func addNote(_ sender: UIButton) {
        let text = newNoteText.text ?? ""
        
        if text == "" {
            showAlert(title: "Error", message: "Please, enter some text.")
        } else {
            newNoteInstance?.addNewNote(text: text)
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
