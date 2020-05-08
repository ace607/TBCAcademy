//
//  ViewController.swift
//  notes
//
//  Created by Admin on 5/8/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, newNote, editNote {
    
    @IBOutlet weak var notesTable: UITableView!
    
    var notes = [note]()
    
    let newFileManager = CustomFM.defaultManager()
    let directory = "notes"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        notesTable.delegate = self
        notesTable.dataSource = self
        if !newFileManager.dirExists(dir: directory) {
            newFileManager.createDirectory(name: directory)
        }
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "add_note_segue" {
            if let addNote = segue.destination as? addNoteViewController {
                addNote.newNoteInstance = self
            }
        }
    }
    
    func addNewNote(text: String) {
        let noteID = newFileManager.noteList(dir: directory).count + UDStandard.deletedCount()
        newFileManager.createFile(dir: directory, text: text, id: noteID)
        notesTable.reloadData()
    }
    
    func sendEdited(text: String, row: Int) {
        try! text.write(to: newFileManager.noteList(dir: directory)[row].absoluteURL, atomically: true, encoding: .utf8)
        notesTable.reloadData()
        print(row)
    }

}

struct note {
    var noteText: String
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newFileManager.noteList(dir: directory).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notesTable.dequeueReusableCell(withIdentifier: "note_cell", for: indexPath) as! noteTableViewCell
        
        cell.noteText.text = newFileManager.getNote(dir: directory, at: newFileManager.noteList(dir: directory)[indexPath.row])
        
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsVC = storyboard.instantiateViewController(withIdentifier: "note_details_vc")
        
        if let detailsView = detailsVC as? noteDetailsViewController {
            detailsView.noteTextContent = newFileManager.getNote(dir: directory, at: newFileManager.noteList(dir: directory)[indexPath.row])
        }
        
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, handler) in
            self.newFileManager.delete(dir: self.directory, url: self.newFileManager.noteList(dir: self.directory)[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .left)
            handler(true)
            let lastDeletedCount = UDStandard.deletedCount()
            UDStandard.addDeletedCount(value: lastDeletedCount + 1)
        }

        let edit = UIContextualAction(style: .normal, title: "Edit") { (action, view, handler) in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let editVC = storyboard.instantiateViewController(withIdentifier: "edit_note_vc")
            
            if let editNoteView = editVC as? editNoteViewController {
                editNoteView.editNoteTextContent = self.newFileManager.getNote(dir: self.directory, at: self.newFileManager.noteList(dir: self.directory)[indexPath.row])
                editNoteView.editNoteDelegate = self
                editNoteView.editingRow = indexPath.row

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
}

