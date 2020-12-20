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
    let API_KEY = "8b41eeed0c4ecf6681aec0927ca46e35a3c700fcada51f4338ae70dca0f01420"
    
    
    
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
