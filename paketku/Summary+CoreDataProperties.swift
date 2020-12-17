//
//  Summary+CoreDataProperties.swift
//  paketku
//
//  Created by Abhi Wisesa on 16/12/20.
//  Copyright © 2020 Abhi Wisesa. All rights reserved.
//
//

import Foundation
import CoreData


extension Summary {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Summary> {
        return NSFetchRequest<Summary>(entityName: "Summary")
    }

    @NSManaged public var amount: String?
    @NSManaged public var awb: String?
    @NSManaged public var courier: String?
    @NSManaged public var date: String?
    @NSManaged public var desc: String?
    @NSManaged public var service: String?
    @NSManaged public var status: String?
    @NSManaged public var weight: String?
    @NSManaged public var dataSummary: Data?

}
