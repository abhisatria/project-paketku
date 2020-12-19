//
//  Shipment+CoreDataProperties.swift
//  paketku
//
//  Created by Abhi Wisesa on 18/12/20.
//  Copyright © 2020 Abhi Wisesa. All rights reserved.
//
//

import Foundation
import CoreData


extension Shipment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Shipment> {
        return NSFetchRequest<Shipment>(entityName: "Shipment")
    }

    @NSManaged public var awb: String?
    @NSManaged public var courier: String?
    @NSManaged public var index: Int32
    @NSManaged public var user: User?

}
