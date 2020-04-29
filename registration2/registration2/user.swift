//
//  user.swift
//  registration2
//
//  Created by Admin on 4/29/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation

class user {
    var firstName: String
    var lastName: String
    var email: String
    var age: Int
    var phone: Int
    var gender: String
    
    init(firstName: String, lastName: String, email: String, age: Int, phone: Int, gender: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.age = age
        self.phone = phone
        self.gender = gender
    }
}
