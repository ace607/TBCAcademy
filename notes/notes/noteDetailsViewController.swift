//
//  noteDetailsViewController.swift
//  notes
//
//  Created by Admin on 5/8/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class noteDetailsViewController: UIViewController {

    @IBOutlet weak var noteText: UILabel!
    
    var noteTextContent: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        noteText.text = noteTextContent
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
