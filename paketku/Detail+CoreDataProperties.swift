//
//  Detail+CoreDataProperties.swift
//  paketku
//
//  Created by Abhi Wisesa on 16/12/20.
//  Copyright © 2020 Abhi Wisesa. All rights reserved.
//
//

import Foundation
import CoreData


extension Detail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Detail> {
        return NSFetchRequest<Detail>(entityName: "Detail")
    }

    @NSManaged public var destination: String?
    @NSManaged public var origin: String?
    @NSManaged public var receiver: String?
    @NSManaged public var shipper: String?
    @NSManaged public var dataDetail: Data?

}
