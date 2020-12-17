//
//  History+CoreDataProperties.swift
//  paketku
//
//  Created by Abhi Wisesa on 16/12/20.
//  Copyright © 2020 Abhi Wisesa. All rights reserved.
//
//

import Foundation
import CoreData


extension History {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<History> {
        return NSFetchRequest<History>(entityName: "History")
    }

    @NSManaged public var date: String?
    @NSManaged public var desc: String?
    @NSManaged public var location: String?
    @NSManaged public var dataHistory: Data?

}
