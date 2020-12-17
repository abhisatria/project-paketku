//
//  ViewController.swift
//  paketku
//
//  Created by Abhi Wisesa on 15/12/20.
//  Copyright © 2020 Abhi Wisesa. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        do {
//            try loadData(awb: "IDS006707756898", kurir: "ide")
//        } catch {
//
//        }
        
        var arr = DatabaseHelper.instance.getAllShipment()
        print(arr.count)
        print(arr[0].dataShipment?.summaryInfo?.awb)
        for item in arr{
            print("resi : \(item.dataShipment!.summaryInfo!.awb!)")
        }
    }

    

}

