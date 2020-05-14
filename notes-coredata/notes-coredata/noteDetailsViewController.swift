//
//  noteDetailsViewController.swift
//  notes-coredata
//
//  Created by Admin on 5/15/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class noteDetailsViewController: UIViewController {

    @IBOutlet weak var noteDate: UILabel!
    @IBOutlet weak var noteText: UILabel!
    
    var noteDateValue: String?
    var noteTextValue: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        noteDate.text = noteDateValue
        noteText.text = noteTextValue
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
