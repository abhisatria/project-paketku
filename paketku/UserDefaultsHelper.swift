//
//  UserDefaultsHelper.swift
//  paketku
//
//  Created by Abhi Wisesa on 17/12/20.
//  Copyright © 2020 Abhi Wisesa. All rights reserved.
//
struct currUser{
    var username : String?
    var email: String?
}

import Foundation
class UserDefaultsHelper{
    static let instance = UserDefaultsHelper()
    var currentUser : currUser?
    
    func handleUser(){
        let currUsername = UserDefaults.standard.string(forKey: "username")
        let currEmail = UserDefaults.standard.string(forKey: "email")
        
        currentUser = currUser(username: currUsername, email: currEmail)
    }
    
}
