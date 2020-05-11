//
//  fileDetailsViewController.swift
//  file-manager
//
//  Created by Admin on 5/11/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class fileDetailsViewController: UIViewController {

    @IBOutlet weak var fileContent: UILabel!
    
    var fileContentText: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fileContent.text = fileContentText
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
