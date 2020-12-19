//
//  User+CoreDataProperties.swift
//  paketku
//
//  Created by Abhi Wisesa on 17/12/20.
//  Copyright © 2020 Abhi Wisesa. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var username: String?
    @NSManaged public var items: NSSet?
    
    public var itemArray : [Shipment]{
        let set = items as? Set<Shipment> ?? []
        return set.sorted{
            $0.index > $1.index
        }
    }

}

// MARK: Generated accessors for items
extension User {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: Shipment)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: Shipment)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}
