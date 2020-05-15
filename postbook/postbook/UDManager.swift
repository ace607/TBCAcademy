//
//  UDManager.swift
//  postbook
//
//  Created by Admin on 5/15/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//


import Foundation
import UIKit

class UDManager {
    private static let USER_LOGGED_IN = "USER_LOGGED_IN"
    private static let CURRENT_USER = "CURRENT_USER"
    
    static func changeUserLogged(_ mode: Bool) {
        UserDefaults.standard.set(mode, forKey: USER_LOGGED_IN)
    }
    
    static func setCurrentUser(_ currentUser: String) {
        UserDefaults.standard.set(currentUser, forKey: CURRENT_USER)
    }
    
    static func getUserLogged() -> Bool {
        return UserDefaults.standard.bool(forKey: USER_LOGGED_IN)
    }
    
    static func getCurrentUser() -> String {
        return UserDefaults.standard.string(forKey: CURRENT_USER) ?? ""
    }
}
