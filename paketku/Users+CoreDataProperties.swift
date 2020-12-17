//
//  Users+CoreDataProperties.swift
//  paketku
//
//  Created by Abhi Wisesa on 17/12/20.
//  Copyright © 2020 Abhi Wisesa. All rights reserved.
//
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var attribute: String?
    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var username: String?
    @NSManaged public var item: NSSet?

}

// MARK: Generated accessors for item
extension Users {

    @objc(addItemObject:)
    @NSManaged public func addToItem(_ value: Shipment)

    @objc(removeItemObject:)
    @NSManaged public func removeFromItem(_ value: Shipment)

    @objc(addItem:)
    @NSManaged public func addToItem(_ values: NSSet)

    @objc(removeItem:)
    @NSManaged public func removeFromItem(_ values: NSSet)

}
