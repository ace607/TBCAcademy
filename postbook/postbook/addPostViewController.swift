//
//  addPostViewController.swift
//  postbook
//
//  Created by Admin on 5/15/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

protocol addPost {
    func newPost(content: String)
}

class addPostViewController: UIViewController {
    @IBOutlet weak var postContent: UITextView!
    
    var addPostDelegate: addPost?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    @IBAction func onAdd(_ sender: UIButton) {
        if postContent.text == "" {
            showAlert(title: "Error", message: "Please, enter post content.")
        } else {
            addPostDelegate?.newPost(content: postContent.text!)
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
