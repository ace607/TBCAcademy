//
//  DetailsViewController.swift
//  hw54-carousel
//
//  Created by Admin on 7/5/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var charPhoto: UIImageView!
    @IBOutlet weak var charName: UILabel!
    @IBOutlet weak var charNickname: UILabel!
    @IBOutlet weak var charBirth: UILabel!
    @IBOutlet weak var charOccupation: UILabel!
    
    var selectedCharacter: Character?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedCharacter?.img.downloadImage { (img) in
            DispatchQueue.main.async {
                self.charPhoto.image = img
            }
        }
        
        charName.text = selectedCharacter?.name
        charNickname.text = "Nickname: \(selectedCharacter!.nickname)"
        charBirth.text = "Birthday: \(selectedCharacter!.birthday)"
        charOccupation.text = "Occupation: \(selectedCharacter!.occupation.joined(separator: ", "))"
        
        
    }

}
