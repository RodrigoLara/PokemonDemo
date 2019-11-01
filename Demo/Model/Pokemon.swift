//
//  Pokemon.swift
//  Demo
//
//  Created by Rodrigo Lara on 10/31/19.
//  Copyright © 2019 Kingtide. All rights reserved.
//

import Foundation

class Pokemon: NSObject {
    var id: Int         = 0
    var height: Int     = 0
    var weight: Int     = 0
    var name: String    = ""
    var image: String   = ""
    
    init(withDic dic: NSDictionary) {
        super.init()
        
        id = dic["id"] as? Int ?? 0
        height = dic["height"] as? Int ?? 0
        weight = dic["weight"] as? Int ?? 0
        name = dic["name"] as? String ?? ""
        
        guard let sprites = dic["sprites"] as? NSDictionary else { return }
        
        image = sprites["front_default"] as? String ?? ""
    }
    
//    class func arrayData(_ jsonArray: NSArray) -> [ActivityModel] {
//        var activityArray: [ActivityModel] = []
//
//        for object in jsonArray {
//            if let dic = object as? NSDictionary {
//                activityArray.append(ActivityModel(withDic: dic))
//            }
//        }
//
//        return activityArray
//    }
}
