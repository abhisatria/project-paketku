//
//  Shipment+CoreDataProperties.swift
//  paketku
//
//  Created by Abhi Wisesa on 17/12/20.
//  Copyright © 2020 Abhi Wisesa. All rights reserved.
//
//

import Foundation
import CoreData


extension Shipment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Shipment> {
        return NSFetchRequest<Shipment>(entityName: "Shipment")
    }

    @NSManaged public var message: String?
    @NSManaged public var status: Int32
    @NSManaged public var dataShipment: Data?
    @NSManaged public var user: Users?

}
