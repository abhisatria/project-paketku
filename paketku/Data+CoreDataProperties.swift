//
//  Data+CoreDataProperties.swift
//  paketku
//
//  Created by Abhi Wisesa on 17/12/20.
//  Copyright © 2020 Abhi Wisesa. All rights reserved.
//
//

import Foundation
import CoreData


extension Data {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Data> {
        return NSFetchRequest<Data>(entityName: "Data")
    }

    @NSManaged public var detailInfo: Detail?
    @NSManaged public var historyInfo: NSSet?
    @NSManaged public var resi: Shipment?
    @NSManaged public var summaryInfo: Summary?

}

// MARK: Generated accessors for historyInfo
extension Data {

    @objc(addHistoryInfoObject:)
    @NSManaged public func addToHistoryInfo(_ value: History)

    @objc(removeHistoryInfoObject:)
    @NSManaged public func removeFromHistoryInfo(_ value: History)

    @objc(addHistoryInfo:)
    @NSManaged public func addToHistoryInfo(_ values: NSSet)

    @objc(removeHistoryInfo:)
    @NSManaged public func removeFromHistoryInfo(_ values: NSSet)

}
