//
//  DetailsViewController.swift
//  hw47-vc-transitions
//
//  Created by Admin on 6/25/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var treeBg: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var textBg: UIView!
    
    var tree: Tree?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        treeBg.image = tree?.image
        titleLabel.text = tree?.name
        descLabel.text = tree?.description
        
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissVC)))
        
        
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        titleLabel.alpha = 0
        descLabel.alpha = 0
        
        textBg.alpha = 0
        
    }
    
    

}
