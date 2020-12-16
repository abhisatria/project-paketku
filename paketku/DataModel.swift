//
//  DataModel.swift
//  paketku
//
//  Created by Stanislaus  Gerry on 15/12/20.
//  Copyright © 2020 Abhi Wisesa. All rights reserved.
//

import Foundation


struct CekResi:Decodable{
    var status: Int
    var message: String
    var data: CekData
}

struct CekData:Decodable {
    var summary:SummaryInfo
    var detail:DetailInfo
    var history:[HistoryInfo]
}

struct SummaryInfo:Decodable {
    var awb:String
    var courier:String
    var service:String
    var status:String
    var date:String
    var desc:String
    var amount:String
    var weight:String
}

struct DetailInfo:Decodable {
    var origin:String
    var destination:String
    var shipper:String
    var receiver:String
}


struct HistoryInfo:Decodable {
    var date: String
    var desc: String
    var location: String
}

//{
//    "status": 200,
//    "message": "Successfully tracked package",
//    "data": {
//        "summary": {
//            "awb": "170430045644420",
//            "courier": "JNE Express",
//            "service": "REG",
//            "status": "DELIVERED",
//            "date": "2020-10-26 11:06:00",
//            "desc": "SEPATU ",
//            "amount": "20000",
//            "weight": "2"
//        },
//        "detail": {
//            "origin": "CILEGON",
//            "destination": "KEBAYORAN LAMA,JKT S",
//            "shipper": "MARTIN ",
//            "receiver": "KICK AVENUE HQ "
//        },
//        "history": [
//            {
//                "date": "2020-10-26 11:06:00",
//                "desc": "DELIVERED TO [ZAINI | 26-10-2020 11:06 | JAKARTA ]",
//                "location": ""
//            },
//            {
//                "date": "2020-10-26 08:38:00",
//                "desc": "WITH DELIVERY COURIER []",
//                "location": ""
//            },
//            {
//                "date": "2020-10-25 07:58:00",
//                "desc": "RECEIVED AT INBOUND STATION [JAKARTA , HUB VETERAN BINTARO]",
//                "location": ""
//            },
//            {
//                "date": "2020-10-25 05:58:00",
//                "desc": "SHIPMENT FORWARDED TO DESTINATION [JAKARTA , HUB VETERAN BINTARO]",
//                "location": ""
//            },
//            {
//                "date": "2020-10-25 00:59:00",
//                "desc": "RECEIVED AT WAREHOUSE [JAKARTA]",
//                "location": ""
//            },
//            {
//                "date": "2020-10-24 21:55:00",
//                "desc": "PROCESSED AT SORTING CENTER [CILEGON]",
//                "location": ""
//            },
//            {
//                "date": "2020-10-24 16:24:00",
//                "desc": "RECEIVED AT SORTING CENTER [CILEGON]",
//                "location": ""
//            },
//            {
//                "date": "2020-10-24 12:07:00",
//                "desc": "SHIPMENT RECEIVED BY JNE COUNTER OFFICER AT [CILEGON]",
//                "location": ""
//            }
//        ]
//    }
//}
