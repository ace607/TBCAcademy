//
//  addFileViewController.swift
//  file-manager
//
//  Created by Admin on 5/11/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit


protocol newFile {
    func createFile(name: String, text: String)
    func editFile(text: String, index: Int)
}

class addFileViewController: UIViewController {
    
    @IBOutlet weak var fileName: UITextField!
    @IBOutlet weak var fileText: UITextView!
    @IBOutlet weak var addEditButton: UIButton!
    
    var createFileDelegate: newFile?
    var currentFolder: String?
    
    var isEditingFile = false
    
    var editingIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print(isEditingFile)
        
        if isEditingFile {
            addEditButton.setTitle("Edit File", for: .normal)
            fileName.isUserInteractionEnabled = false
            let editFileName = CustomFM.defaultManager().fileList(dir: self.currentFolder!)[editingIndex!].lastPathComponent
            fileText.text = CustomFM.defaultManager().readFile(dir: currentFolder!, name: editFileName)
            
            fileName.text = editFileName
            
        } else {
            addEditButton.setTitle("Add File", for: .normal)
            fileName.isUserInteractionEnabled = true
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    @IBAction func addFile(_ sender: UIButton) {
        if fileName.text == "" || fileText.text == "" {
            showAlert(title: "Error", message: "Please, enter file name and text.")
        } else if CustomFM.defaultManager().fileExists(dir: currentFolder!, name: fileName.text!) {
            showAlert(title: "Error", message: "File with this name already exists!")
        } else {
            if !isEditingFile {
                createFileDelegate?.createFile(name: fileName.text!, text: fileText.text!)
            } else {
                createFileDelegate?.editFile(text: fileText.text!, index: editingIndex!)
            }
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
