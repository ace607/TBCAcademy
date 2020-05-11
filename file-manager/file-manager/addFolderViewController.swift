//
//  addFolderViewController.swift
//  file-manager
//
//  Created by Admin on 5/11/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

protocol newFolder {
    func createFolder(name: String)
}

class addFolderViewController: UIViewController {

    @IBOutlet weak var folderName: UITextField!
    
    var createFolderDelegate: newFolder?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    
    @IBAction func addFolder(_ sender: UIButton) {
        if folderName.text == "" {
            showAlert(title: "Error", message: "Please, enter folder name.")
        } else if CustomFM.defaultManager().dirExists(dir: folderName.text!) {
            showAlert(title: "Error", message: "Folder with this name already exists!")
        } else {
            createFolderDelegate?.createFolder(name: folderName.text!)
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
