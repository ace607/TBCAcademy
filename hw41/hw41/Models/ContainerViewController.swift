//
//  ContainerViewController.swift
//  hw41
//
//  Created by Admin on 6/16/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    @IBOutlet weak var customTabView: UIView!
    
    var homeViewController: HomeViewController = {
        let storyboard = UIStoryboard(name: "home", bundle: nil)
        
        let viewController = storyboard.instantiateViewController(identifier: "home_main_controller") as! HomeViewController
        
        return viewController
    }()
    
    var mapViewController: MapViewController = {
        let storyboard = UIStoryboard(name: "map", bundle: Bundle.main)
        
        let viewController = storyboard.instantiateViewController(identifier: "map_main_controller") as! MapViewController
        
        return viewController
    }()
    var coffeeViewController: CoffeeViewController = {
        let storyboard = UIStoryboard(name: "coffee", bundle: Bundle.main)
        
        let viewController = storyboard.instantiateViewController(identifier: "coffee_main_controller") as! CoffeeViewController
        
        return viewController
    }()
    var profileViewController: ProfileViewController = {
        let storyboard = UIStoryboard(name: "profile", bundle: Bundle.main)
        
        let viewController = storyboard.instantiateViewController(identifier: "profile_main_controller") as! ProfileViewController
        
        return viewController
    }()
    
    var lastView = UIView()
    var selectedItem: Int?
    
    
    @IBOutlet weak var tabItemsStack: UIStackView!
    override func loadView() {
        super.loadView()
        
        view.insertSubview(homeViewController.view, belowSubview: customTabView)
        lastView = homeViewController.view
        selectedItem = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        customTabView.layer.cornerRadius = 46
        customTabView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        customTabView.layer.masksToBounds = true
        
        updateTabs()
        
    }
    
    func changeController(id: Int) {
        lastView.removeFromSuperview()
        
        switch id {
        case 0:
            view.insertSubview(homeViewController.view, belowSubview: customTabView)
            lastView = homeViewController.view
            selectedItem = 0
        case 1:
            view.insertSubview(mapViewController.view, belowSubview: customTabView)
            lastView = mapViewController.view
            selectedItem = 1
        case 2:
            view.insertSubview(coffeeViewController.view, belowSubview: customTabView)
            lastView = coffeeViewController.view
            selectedItem = 2
        case 3:
            view.insertSubview(profileViewController.view, belowSubview: customTabView)
            lastView = profileViewController.view
            selectedItem = 3
        default:
            print("a")
        }
        updateTabs()
        view.layoutIfNeeded()
        
    }
    
    func updateTabs() {
        tabItemsStack.subviews.forEach { (b) in
            b.alpha = selectedItem == b.tag ? 1 : 0.3
        }
    }
    
    @IBAction func onHome(_ sender: UIButton) {
        changeController(id: 0)
    }
    
    @IBAction func onMap(_ sender: UIButton) {
        changeController(id: 1)
    }
    @IBAction func onCoffee(_ sender: UIButton) {
        changeController(id: 2)
    }
    @IBAction func onProfile(_ sender: UIButton) {
        changeController(id: 3)
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
