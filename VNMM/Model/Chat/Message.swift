//
//  Message.swift
//  VNMM
//
//  Created by Nguyen Tan Dung on 05/09/21.
//

import Foundation
import ObjectMapper

class Message: Mappable {
    
    var room = ""
    var message = ""
    var user_first_id = ""
    var images = [String]()
    var sender = ""
    var user_second_id = ""
    
    init() {}
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        room                                             <- map["room"]
        message                                       <- map["message"]
        user_first_id                                   <- map["user_first_id"]
        images                                       <- map["images"]
        sender                                       <- map["sender"]
        user_second_id                                  <- map["user_second_id"]
       
    }
    
}


class MessageResponse: Mappable {
    
    var limit = 0
    var total_record = 0
    var list = [Message]()
    
    init() {}
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        limit                                        <- map["limit"]
        total_record                                 <- map["total_record"]
        list                                         <- map["list"]
        
    }
    
}

