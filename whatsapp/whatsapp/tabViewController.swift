//
//  tabViewController.swift
//  whatsapp
//
//  Created by Admin on 5/7/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class tabViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.selectedIndex = 1
        
//        let getSelected = UDStandard.getSelected()
        
        switch UDStandard.getSelected() {
        case 0:
            print("didnt select")
            case 1:
                self.selectedIndex = 0
            case 2:
                self.selectedIndex = 1
            case 3:
                self.selectedIndex = 2
            default:
                print("")
        }
        
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let tappedIndex = (tabBar.items?.firstIndex(of: item))! + 1
        UDStandard.setSelected(tappedIndex)
        print(UDStandard.getSelected())
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

