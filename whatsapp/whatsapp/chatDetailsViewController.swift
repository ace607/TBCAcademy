//
//  chatDetailsViewController.swift
//  whatsapp
//
//  Created by Admin on 5/7/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class chatDetailsViewController: UIViewController {

    @IBOutlet weak var chatImage: UIImageView!
    @IBOutlet weak var chatNAme: UILabel!
    @IBOutlet weak var chatMessage: UILabel!
    
    var getChatImage: UIImage?
    var getChatName: String?
    var getChatMesage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        chatImage.image = getChatImage
        chatNAme.text = getChatName
        chatMessage.text = getChatMesage
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
