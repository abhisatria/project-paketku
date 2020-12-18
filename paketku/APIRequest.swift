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
    let API_KEY = "3ba9aac91710f74b9956bf97258e86062a0f1ecbb4d6c2d29ca178998eb2847f"
    
    
    
    init(awb:String, courier:String) {
        let ResouceString = "https://api.binderbyte.com/v1/track?api_key=\(API_KEY)&courier=\(courier)&awb=\(awb)"
        
        guard let resourceURL = URL(string: ResouceString) else {fatalError()}
        
        self.resourceURL = resourceURL
    }
}
    

    
//func loadData(awb: String, courier: String) {
//        
//        var request = URLRequest(url: ApiRequest.init(awb: "170430045644420", courier: "jne").resourceURL)
//        
//        request.httpMethod = "GET"
//        
//        let task =  URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
//            
//            var result: CekResi?
//
//            do{
//                result = try JSONDecoder().decode(CekResi.self, from: data!)
//            }
//            catch{
//                print("json failed \(error.localizedDescription)")
//            }
//
//            guard let json = result else {
//                return
//            }
//
//            print(json.status)
//            print(json.message)
//
//            
//        })
//        task.resume()
//    
//        
//    }
