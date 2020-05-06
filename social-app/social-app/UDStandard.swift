//
//  UDStandard.swift
//  social-app
//
//  Created by Admin on 5/6/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit
import Foundation

class UDStandard {
    private static let USERNAME = "USERNAME"
    private static let PASSWORD = "PASSWORD"
    private static let EMAIL = "EMAIL"
    
    private static let ISSIGNEDIN = "ISSIGNEDIN"
    
    private static let MESSAGE = "MESSAGE"
    private static let BGCOLOR = "BGCOLOR"
    
    static func setUserName(_ value: String) {
        UserDefaults.standard.set(value, forKey: USERNAME)
    }
    
    static func setPassword(_ value: String) {
        UserDefaults.standard.set(value, forKey: PASSWORD)
    }
    
    static func setEmail(_ value: String) {
        UserDefaults.standard.set(value, forKey: EMAIL)
    }
    
    static func setSignedIn(_ value: Bool) {
        UserDefaults.standard.set(value, forKey: ISSIGNEDIN)
    }
    
    static func setMessage(_ value: String) {
        UserDefaults.standard.set(value, forKey: MESSAGE)
    }
    
    static func setBG(_ value: String) {
        UserDefaults.standard.set(value, forKey: BGCOLOR)
    }
    
    static func getUserName() -> String {
        return UserDefaults.standard.string(forKey: USERNAME) ?? ""
    }
    
    static func getPassword() -> String {
        return UserDefaults.standard.string(forKey: PASSWORD) ?? ""
    }
    
    static func getEmail() -> String {
        return UserDefaults.standard.string(forKey: EMAIL) ?? ""
    }
    
    static func isSignedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: ISSIGNEDIN)
    }
    
    static func getMessage() -> String {
        return UserDefaults.standard.string(forKey: MESSAGE) ?? "You can edit this message"
    }
    
    static func getBg() -> String {
        return UserDefaults.standard.string(forKey: BGCOLOR) ?? "white"
    }
}
