//
//  ViewController.swift
//  CALayer-hw37
//
//  Created by Admin on 6/9/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var rectView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupLayers()
    }

    func setupLayers() {
        let rectLayer = CALayer()
        let outerCircle = CALayer()
        let innerCircle = CALayer()
        
        rectLayer.frame = CGRect(x: 0, y: 0, width: rectView.frame.width, height: rectView.frame.height)
        rectLayer.backgroundColor = UIColor(red: 88/255, green: 198/255, blue: 173/255, alpha: 1).cgColor
        
        outerCircle.frame = CGRect(x: (rectView.frame.width - 230)/2, y: (rectView.frame.height - 230)/2, width: 230, height: 230)
        outerCircle.backgroundColor = UIColor(red: 74/255, green: 170/255, blue: 154/255, alpha: 1).cgColor
        outerCircle.cornerRadius = outerCircle.frame.width/2
        
        
        innerCircle.frame = CGRect(x: (rectView.frame.width - 140)/2, y: (rectView.frame.height - 140)/2, width: 140, height: 140)
        innerCircle.backgroundColor = UIColor.white.cgColor
        innerCircle.cornerRadius = innerCircle.frame.width/2
        innerCircle.borderWidth = 5
        innerCircle.borderColor = UIColor(red: 127/255, green: 127/255, blue: 127/255, alpha: 1).cgColor
        
        rectView.layer.addSublayer(rectLayer)
        rectView.layer.addSublayer(outerCircle)
        rectView.layer.addSublayer(innerCircle)
        
    }

}

