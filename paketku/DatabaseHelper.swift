//
//  DatabaseHelper.swift
//  paketku
//
//  Created by Abhi Wisesa on 17/12/20.
//  Copyright © 2020 Abhi Wisesa. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DatabaseHelper{
    static let instance = DatabaseHelper()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveShipment(json : CekResi){
        var shipment = Shipment(context: context)
        shipment.status = Int32(json.status)
        shipment.message = json.message
        print(shipment.message)
        
        var dataShipment = Data(context: context)
        
        var dataSummary = Summary(context: context)
        dataSummary.awb = json.data.summary.awb
        dataSummary.courier = json.data.summary.courier
        dataSummary.service = json.data.summary.service
        dataSummary.status = json.data.summary.status
        dataSummary.date = json.data.summary.date
        dataSummary.desc = json.data.summary.desc
        dataSummary.amount = json.data.summary.amount
        dataSummary.weight = json.data.summary.weight
        
        var dataDetail = Detail(context: context)
        dataDetail.origin = json.data.detail.origin
        dataDetail.destination = json.data.detail.destination
        dataDetail.shipper = json.data.detail.shipper
        dataDetail.receiver = json.data.detail.receiver
        
        
        for histories in json.data.history{
            var history = History(context: context)
            history.date = histories.date
            history.desc = histories.desc
            history.location = histories.location
            print(history.desc)
            dataShipment.addToHistoryInfo(history)
        }
        
        dataShipment.summaryInfo = dataSummary
        dataShipment.detailInfo = dataDetail
        
        shipment.dataShipment = dataShipment
                
        do{
            try context.save()
        }catch let error{
            print(error.localizedDescription)
        }
    }
    
    func getAllShipment() -> [Shipment]{
        var arrShipment = [Shipment]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Shipment")
        do{
            arrShipment = try context.fetch(fetchRequest) as! [Shipment]
        }catch let error{
            print(error.localizedDescription)
        }
        
        return arrShipment
    }
}
