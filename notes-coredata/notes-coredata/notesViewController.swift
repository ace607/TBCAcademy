//
//  notesViewController.swift
//  notes-coredata
//
//  Created by Admin on 5/14/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit
import CoreData

class notesViewController: UIViewController, addNote, editNote {
    
    @IBOutlet weak var notesTable: UITableView!
    
    var currentUser: String?
    
    var editingIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        notesTable.delegate = self
        notesTable.dataSource = self
        
        self.navigationItem.hidesBackButton = true
    }
    
    func addNewNote(content: String) {
        addUserNote(text: content)
        notesTable.reloadData()
    }
    
    func editNoteFunc(newText: String) {
        editExistingNote(newText, note: getNotes()[editingIndex!])
        notesTable.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "add_note_segue" {
            if let addNoteVC = segue.destination as? addNoteViewController {
                addNoteVC.addNoteDelegate = self
            }
        }
    }
    @IBAction func onLogOut(_ sender: UIButton) {
        UDManager.changeUserLogged(false)
        self.navigationController?.popViewController(animated: true)
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

extension notesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsVC = storyboard.instantiateViewController(withIdentifier: "note_details_vc")

        if let detailsView = detailsVC as? noteDetailsViewController {
            let formatter = DateFormatter()
            formatter.dateFormat = "E, d MMM HH:mm"
            detailsView.noteDateValue = formatter.string(from: getNotes()[indexPath.row].date!)
            detailsView.noteTextValue = getNotes()[indexPath.row].content
        }
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, handler) in
            self.deleteExistingNote(note: self.getNotes()[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .left)
            handler(true)
        }

        let edit = UIContextualAction(style: .normal, title: "Edit") { (action, view, handler) in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let editVC = storyboard.instantiateViewController(withIdentifier: "edit_note_vc")
            
            self.editingIndex = indexPath.row
            
            if let editNoteView = editVC as? editNoteViewController {
                
                editNoteView.editNoteDelegate = self
                editNoteView.editingText = self.getNotes()[indexPath.row].content

                handler(true)
            }
            
            self.navigationController?.pushViewController(editVC, animated: true)
            
            
        }
        
        edit.backgroundColor = .systemIndigo
        edit.image = UIImage(named: "edit")
        
        
        delete.image = UIImage(named: "delete")
        
        delete.backgroundColor = .systemPink

        let config = UISwipeActionsConfiguration(actions: [delete, edit])
        return config
    }
}

extension notesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getNotes().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notesTable.dequeueReusableCell(withIdentifier: "note_cell", for: indexPath) as! noteTableViewCell
        
        cell.noteLabel.text = getNotes()[indexPath.row].content
        
        return cell
    }
}

extension notesViewController {
    
    func fetchUsers() -> [User] {
        let context = AppDelegate.coreDataContainer.viewContext
        
        let request: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let result = try context.fetch(request)
            
            let users = result as [User]
            
            return users
        } catch {
            print("ERROR: Couldn't fetch podcasts")
        }
        
        return []
    }
    func getNotes() -> [Note] {
        
        var user: User?
        
        for userMatch in fetchUsers() {
            if userMatch.username == currentUser! {
                user = userMatch
            }
        }

        return ((user!.notes?.allObjects as NSArray?) as! [Note]).sorted(by: { ($0.date!).compare($1.date!) == .orderedDescending })
    }
    
    func addUserNote(text: String) {
        
        let context = AppDelegate.coreDataContainer.viewContext
        let entityDescriptionNote = NSEntityDescription.entity(forEntityName: "Note", in: context)
        
        var user: User?
        
        for userMatch in fetchUsers() {
            if userMatch.username == currentUser! {
                user = userMatch
            }
        }
        
        let note = Note(entity: entityDescriptionNote!, insertInto: context)
        
        note.content = text
        note.author = user
        note.date = Date()

        do {
            try context.save()
        } catch {
            
        }
    }
    
    func editExistingNote(_ newContent: String, note: Note) {
        let context = AppDelegate.coreDataContainer.viewContext
        note.content = newContent
        
        do {
            try context.save()
        } catch {
            
        }
    }
    
    func deleteExistingNote(note: Note) {
        let context = AppDelegate.coreDataContainer.viewContext
        context.delete(note)
        do {
            try context.save()
        } catch {
            
        }
    }
//    func deleteNote(
}
