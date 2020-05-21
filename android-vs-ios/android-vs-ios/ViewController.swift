//
//  ViewController.swift
//  android-vs-ios
//
//  Created by Admin on 5/21/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var resultImage: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var chooseButton: UIButton!
    
    let androidChoiceText = "OK BOOMER"
    let iosChoiceText = "Welcome to the iOS gang ;)"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        chooseButton.layer.cornerRadius = 25
        
        let url = URL(string: "https://www.quertime.com/wp-content/uploads/2014/05/apple_quarreling_with_android.jpg")
        resultImage.kf.setImage(with: url)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didRecievePlatform(with:)),
            name: .platformName,
            object: nil)
        
    }

    @IBAction func onChoose(_ sender: UIButton) {
        performSegue(withIdentifier: "choose_platform_segue", sender: nil)
    }
    
    @objc func didRecievePlatform(with notification: Notification) {
        if let platformInfo = notification.userInfo {
            if platformInfo["platform"] as! String == "ios" {
                let url = URL(string: "https://i.pinimg.com/originals/00/85/91/00859139e0f2aeb8f990ffcdaa544e31.png")
                resultImage.kf.setImage(with: url)
                resultLabel.text = iosChoiceText
            } else if platformInfo["platform"] as! String == "android" {
                let url = URL(string: "https://optus.i.lithium.com/t5/image/serverpage/image-id/10327iB4BBF502EE5A5C36?v=1.0")
                resultImage.kf.setImage(with: url)
                resultLabel.text = androidChoiceText
            }
        }
    }
    
}

extension NSNotification.Name {
    static let platformName = NSNotification.Name("platform_name")
}
