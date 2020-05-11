//
//  folderDetailsViewController.swift
//  file-manager
//
//  Created by Admin on 5/11/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class folderDetailsViewController: UIViewController, newFile {
  
    @IBOutlet weak var fileList: UITableView!
    
    var currentFolder: String?
    
    var isEditingFile = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        fileList.delegate = self
        fileList.dataSource = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func createFile(name: String, text: String) {
        CustomFM.defaultManager().createFile(dir: currentFolder!, text: text, name: name)
        fileList.reloadData()
    }
    
    func editFile(text: String, index: Int) {
        try! text.write(to: CustomFM.defaultManager().fileList(dir: currentFolder!)[index], atomically: true, encoding: .utf8)
        fileList.reloadData()
      }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "add_file_segue" {
            if let addFileVC = segue.destination as? addFileViewController {
                addFileVC.createFileDelegate = self
                addFileVC.currentFolder = currentFolder!
            }
        }
    }
}

extension folderDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, handler) in
            CustomFM.defaultManager().deleteFile(url: CustomFM.defaultManager().fileList(dir: self.currentFolder!)[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .left)
            handler(true)
            
        }
        let edit = UIContextualAction(style: .normal, title: "Edit") { (action, view, handler) in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let editVC = storyboard.instantiateViewController(withIdentifier: "add_file_vc")

              self.isEditingFile = true
            if let editFileView = editVC as? addFileViewController {
                
                
                editFileView.isEditingFile = self.isEditingFile
                editFileView.title = "Editing \(CustomFM.defaultManager().fileList(dir: self.currentFolder!)[indexPath.row].lastPathComponent)"
                
                editFileView.editingIndex = indexPath.row
                editFileView.currentFolder = self.currentFolder
                
                editFileView.createFileDelegate = self
                
                
                handler(true)
            }
              
            self.navigationController?.pushViewController(editVC, animated: true)
        }
           
        edit.backgroundColor = .systemIndigo
        edit.image = UIImage(named: "edit")
           
           
        delete.image = UIImage(named: "delete")

        let config = UISwipeActionsConfiguration(actions: [delete, edit])
        return config
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let fileVC = storyboard.instantiateViewController(withIdentifier: "file_details_vc")

        if let fileDetailsVC = fileVC as? fileDetailsViewController {
            
            fileDetailsVC.fileContentText = CustomFM.defaultManager().readFile(dir: currentFolder!, name: CustomFM.defaultManager().fileList(dir: currentFolder!)[indexPath.row].lastPathComponent)
            
            fileDetailsVC.title = CustomFM.defaultManager().fileList(dir: currentFolder!)[indexPath.row].lastPathComponent
            
        }
          
        self.navigationController?.pushViewController(fileVC, animated: true)
    }
}

extension folderDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CustomFM.defaultManager().fileList(dir: currentFolder!).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = fileList.dequeueReusableCell(withIdentifier: "file_cell", for: indexPath) as! fileTableViewCell
        
        cell.fileLabel.text = CustomFM.defaultManager().fileList(dir: currentFolder!)[indexPath.row].lastPathComponent
        
        return cell
    }
}
