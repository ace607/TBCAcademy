//
//  PlatformsViewController.swift
//  android-vs-ios
//
//  Created by Admin on 5/21/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit
import Kingfisher

class PlatformsViewController: UIViewController {

    @IBOutlet weak var iosImage: UIImageView!
    @IBOutlet weak var androidImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let iosURL = URL(string: "https://i.pinimg.com/originals/00/85/91/00859139e0f2aeb8f990ffcdaa544e31.png")
        let androidURL = URL(string: "https://optus.i.lithium.com/t5/image/serverpage/image-id/10327iB4BBF502EE5A5C36?v=1.0")
        iosImage.kf.setImage(with: iosURL)
        androidImage.kf.setImage(with: androidURL)
        
        iosImage.isUserInteractionEnabled = true
        androidImage.isUserInteractionEnabled = true
        
        iosImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(sendIOS)))
        androidImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(sendAndroid)))

    }
    
    @objc func sendIOS() {
        NotificationCenter.default.post(name: .platformName, object: nil, userInfo: ["platform":"ios"])
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func sendAndroid() {
        NotificationCenter.default.post(name: .platformName, object: nil, userInfo: ["platform":"android"])
        self.dismiss(animated: true, completion: nil)
    }

}
