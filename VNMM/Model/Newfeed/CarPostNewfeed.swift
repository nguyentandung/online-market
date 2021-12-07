//
//  CarPostNewfeed.swift
//  VNMM
//
//  Created by Nguyen Tan Dung on 04/27/21.
//

import UIKit
import ObjectMapper

class CarPostNewfeed: Mappable {
    var title = ""
    var images = [String]()
    var price = 0
    var content = ""
    var details = CarPostNewfeedResponse()
    var phone_number = ""
    var address = ""
    var type = 0
    
    init() {}
    
    required  init?(map: Map) {
        mapping(map: map)
    }
    
    func  mapping(map: Map) {
        images    <- map["images"]
        title    <- map["title"]
        price    <- map["price"]
        content   <- map["content"]
        details <- map["details"]
        phone_number   <- map["phone_number"]
        address <- map["address"]
        type <- map["type"]
    }
}


class CarPostNewfeedResponse: Mappable {
    var brand = ""
    var model = ""
    var production_location = ""
    var km_used = 0
    var status = ""
    var fuel = ""
    var capacity = ""
    var color = ""
    
    init() {}
    
    required  init?(map: Map) {
        mapping(map: map)
    }
    
    func  mapping(map: Map) {
        brand    <- map["brand"]
        model    <- map["model"]
        production_location    <- map["production_location"]
        km_used   <- map["km_used"]
        status <- map["status"]
        fuel   <- map["fuel"]
        capacity <- map["capacity"]
        color <- map["color"]
    }
}



