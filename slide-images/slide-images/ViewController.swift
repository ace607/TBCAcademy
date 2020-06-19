//
//  ViewController.swift
//  slide-images
//
//  Created by Admin on 6/17/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgOne: UIImageView!
    @IBOutlet weak var imgTwo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imgOne.isUserInteractionEnabled = true
        imgTwo.isUserInteractionEnabled = true
        
        imgOne.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(onSlide)))
        imgTwo.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(onSlide)))
    }

    
    @objc func onSlide(panGesture: UIPanGestureRecognizer) {
        print(panGesture.view)
    }

}

