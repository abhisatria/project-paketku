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
    
    func loadData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        var request = URLRequest(url: ApiRequest.init(awb: "170430045644420", courier: "jne").resourceURL)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            var result: CekResi?
            
            do{
                result = try JSONDecoder().decode(CekResi.self, from: data!)
            }
            catch{
                print("json failed \(error.localizedDescription)")
            }
            
            guard let json = result else {
                return
            }
            
            print(json.status)
            print(json.message)
            
            var resi = Shipment(context: context)
            resi.awb = json.data.summary.awb
            resi.courier = json.data.summary.courier
            do{
                    try context.save()
                }catch let error{
                    print(error.localizedDescription)
                }
        }).resume()
        
    }
    

