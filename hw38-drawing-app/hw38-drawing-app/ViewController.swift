//
//  ViewController.swift
//  hw38-drawing-app
//
//  Created by Admin on 6/10/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let drawView = DrawView()
    
    override func loadView() {
        super.loadView()
        
        self.view.addSubview(drawView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        drawView.frame = self.view.frame
        drawView.backgroundColor = .white
    }


}
