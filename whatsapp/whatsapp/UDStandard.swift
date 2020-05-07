//
//  UDStandard.swift
//  whatsapp
//
//  Created by Admin on 5/7/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//


import UIKit
import Foundation

class UDStandard {
    
    private static let SELECTEDTAB = "SELECTEDTAB"
    
    static func setSelected(_ value: Int) {
        UserDefaults.standard.set(value, forKey: SELECTEDTAB)
    }
    
    static func getSelected() -> Int {
        return UserDefaults.standard.integer(forKey: SELECTEDTAB)
    }
}

