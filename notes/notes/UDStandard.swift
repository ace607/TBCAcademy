//
//  UDStandard.swift
//  notes
//
//  Created by Admin on 5/8/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit
import Foundation

class UDStandard {
    
    private static let DELETEDCOUNT = "DELETEDCOUNT"
    
    
    static func addDeletedCount(value: Int) {
        return UserDefaults.standard.set(value, forKey: DELETEDCOUNT)
    }
    
    static func deletedCount() -> Int {
        return UserDefaults.standard.integer(forKey: DELETEDCOUNT)
    }
}
