//
//  DataModel.swift
//  paketku
//
//  Created by Stanislaus  Gerry on 15/12/20.
//  Copyright © 2020 Abhi Wisesa. All rights reserved.
//

import Foundation

struct CekStatus {
    var status: Int?
}

struct CekMessage:Decodable{
    var message: String
}

struct CekData:Decodable {
    var summary:SummaryInfo
    var detail:DetailInfo
    var history:Histories
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

struct Histories:Decodable{
    var histories: [HistoryInfo]
}

struct HistoryInfo:Decodable {
    var date: String
    var desc: String
    var location: String
}
