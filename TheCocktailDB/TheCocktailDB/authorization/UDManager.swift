//
//  UDManager.swift
//  TheCocktailDB
//
//  Created by Admin on 5/23/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation
import UIKit

class UDManager {
    
    private static let USERSIGNEDIN = "USER_SIGNED_IN"
    private static let CURRENTUSER = "CURRENT_USER"
    
    
    static func setSigned(value: Bool) {
        return UserDefaults.standard.set(value, forKey: USERSIGNEDIN)
    }
    
    static func getSigned() -> Bool {
        return UserDefaults.standard.bool(forKey: USERSIGNEDIN)
    }
    
    static func setUser(value: String) {
        return UserDefaults.standard.set(value, forKey: CURRENTUSER)
    }
    
    static func getUser() -> String {
        return UserDefaults.standard.string(forKey: CURRENTUSER) ?? "No User"
    }
}
