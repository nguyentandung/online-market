//
//  ResResponse.swift
//  GS_iOS
//
//  Created by kelvin on 11/8/18.
//  Copyright © 2018 vn.eteacher. All rights reserved.
//

import UIKit
import ObjectMapper

class ResResponse: Mappable {
    var code: Int?
    var data: AnyObject?
    var social_data: AnyObject?
    var error:Bool?
    var message:String?
    var token:String?
    var total: Int?
    var totalMessage: Int?
    var limit: Int?
    
    init() {}
    
    required  init?(map: Map) {
        mapping(map: map)
    }
    
    func  mapping(map: Map) {
        data    <- map["data"]
        social_data    <- map["entries"]
        code    <- map["status"]
        error   <- map["error"]
        message <- map["message"]
        token   <- map["token"]
        total   <- map["total_record"]
        totalMessage   <- map["totalMessage"]
        limit   <- map["limit"]
    }
}
