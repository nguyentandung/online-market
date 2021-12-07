//
//  NewFeed.swift
//  VNMM
//
//  Created by Nguyen Tan Dung on 04/24/21.
//

import UIKit
import ObjectMapper

class NewFeed: Mappable {
    var _id = ""
    var title = ""
    var content = ""
    var images = [String]()
    var price = 0
    var address = ""
    
    var details = CarPostNewfeedResponse()
    var user_id = ""
    var phone = ""
    var dateUpload = ""
    
    var first_name = ""
    var last_name = ""
    
    var type = 0
    var statusbought = 0
    
    init() {}
    
    required  init?(map: Map) {
        mapping(map: map)
    }
    
    func  mapping(map: Map) {
        _id    <- map["_id"]
        title    <- map["title"]
        images    <- map["images"]
        price   <- map["price"]
        address <- map["address"]
        content <- map["content"]
       
        details <- map["details"]
        
        user_id <- map["user_id"]
        phone <- map["phone_number"]
        type <- map["type"]
        first_name <- map["first_name"]
        last_name <- map["last_name"]
        dateUpload <- map["dateUpload"]
        
        statusbought <- map["statusbought"]
    }
}

class NewFeedResponse: Mappable {
    var limit = 0
    var list = [NewFeed]()
    var total_record = 0
   
    
    init() {}
    
    required  init?(map: Map) {
        mapping(map: map)
    }
    
    func  mapping(map: Map) {
        limit    <- map["limit"]
        list    <- map["list"]
        total_record    <- map["total_record"]
       
    }
}

