//
//  podcastDetailsViewController.swift
//  podcasts
//
//  Created by Admin on 5/13/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class podcastDetailsViewController: UIViewController {
    
    @IBOutlet weak var podTitle: UILabel!
    @IBOutlet weak var podDesc: UILabel!
    @IBOutlet weak var podLength: UILabel!
    
    var podcastTitle: String?
    var podcastDesc: String?
    var podcastLength: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        podTitle.text = podcastTitle
        podDesc.text = podcastDesc
        podLength.text = podcastLength
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
