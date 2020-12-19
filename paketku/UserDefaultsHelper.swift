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
import UIKit
import CoreData

class UserDefaultsHelper{
    static let instance = UserDefaultsHelper()
    var currentUser : currUser?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func handleUser(){
        let currUsername = UserDefaults.standard.string(forKey: "username")
        let currEmail = UserDefaults.standard.string(forKey: "email")
        
        currentUser = currUser(username: currUsername, email: currEmail)
    }
    
    func checkEmail(email : String) -> Bool{
        var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "email = %@",email)
        
        var result = [User]()
        do{
            result = try context.fetch(fetchRequest) as! [User]
            
        }catch let error{
            print(error.localizedDescription)
        }
        
        if result.count == 0{
            return true
        }
        else {
            return false
        }
    }
    func addUserShipment(awb : String,courier : String){
        var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "email = %@",(currentUser?.email!)!)
        
        var result = [User]()
        do{
            result = try context.fetch(fetchRequest) as! [User]
        }catch let error{
            print(error.localizedDescription)
        }
        var user = result[0]
        var shipment = Shipment(context: context)
        shipment.awb = awb
        shipment.courier = courier
        shipment.index = Int32(user.itemArray.count)
        user.addToItems(shipment)
        
        do{
            try context.save()
            print("Save shipment success")
        }catch let error{
            print(error.localizedDescription)
             print("Save shipment failed")
        }
    }
    
    func getUserShipment() -> [Shipment]{
        var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "email = %@",(currentUser?.email!)!)
        
        var result = [User]()
        do{
            result = try context.fetch(fetchRequest) as! [User]
        }catch let error{
            print(error.localizedDescription)
        }
        print(result[0].itemArray)
        return result[0].itemArray
    }
}
