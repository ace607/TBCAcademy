//
//  MainTabBarController.swift
//  hw46-music-app
//
//  Created by Admin on 6/23/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    
    let newTabBarView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        return v
    }()
    
    override func loadView() {
        super.loadView()
        view.insertSubview(newTabBarView, belowSubview: tabBar)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNewTabbar()
    }
    
    private func setupNewTabbar() {
        NSLayoutConstraint.activate([
            newTabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newTabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newTabBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            newTabBarView.topAnchor.constraint(equalTo: tabBar.topAnchor)
        ])
        
        newTabBarView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        let appearance = UITabBar.appearance()
        appearance.backgroundImage = UIImage()
        appearance.shadowImage = UIImage()
        appearance.barTintColor = .clear
    }
    
}
