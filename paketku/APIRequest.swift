//
//  APIRequest.swift
//  paketku
//
//  Created by Stanislaus  Gerry on 16/12/20.
//  Copyright © 2020 Abhi Wisesa. All rights reserved.
//

import Foundation
import CoreData
import UIKit



struct ApiRequest{
    let resourceURL:URL
    let API_KEY = "b3d3cdbb6825ae2a209c66076b1c2e86dfa4ff272e840707c7360a67e2cc7c47"
    
    
    init(awb:String, courier:String) {
        let ResouceString = "https://api.binderbyte.com/v1/track?api_key=\(API_KEY)&courier=\(courier)&awb=\(awb)"
        
        guard let resourceURL = URL(string: ResouceString) else {fatalError()}
        
        self.resourceURL = resourceURL
    }
}
    
//    func getData (from url:String){
//        URLSession.shared.dataTask(with: resourceURL) { (data, response, error) in
//            guard let data = data, error == nil else{
//                print("something went wrong")
//                return
//            }
//            var result = Response?
//            do{
//                result = JSONDecoder().decode(Response.self, from: data)
//            }catch{
//                print("failed to convert\(LocalizedDescription)"))
//            }
//            
//            guard let json = result else {
//                return
//            }
//            
//            print(json.status)
//            
//        }
//    }
    
func loadData(awb : String,kurir : String){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        var request = URLRequest(url: ApiRequest.init(awb: awb, courier: kurir).resourceURL)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            var result: CekResi?
            do{
                result = try JSONDecoder().decode(CekResi.self, from: data!)
                DatabaseHelper.instance.saveShipment(json: result!)
            }
            catch{
                print("json failed \(error.localizedDescription)")
            }
            
            guard let json = result else {
                return
            }
            
            
//            print(json.status)
//            print(json.message)
//            print(json.data.history)
//            print("from apirequest")
            
            
            
        }).resume()
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
    

