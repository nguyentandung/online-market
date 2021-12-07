//
//  MessageEmit.swift
//  VNMM
//
//  Created by Nguyen Tan Dung on 05/06/21.
//

import Foundation
import ObjectMapper
import SocketIO

class MessageEmit : Mappable, SocketData {
    
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
        room                                              <- map["room"]
        message                                       <- map["message"]
        user_first_id                                       <- map["user_first_id"]
        images                                       <- map["images"]
        sender                                       <- map["sender"]
        user_second_id                                       <- map["user_second_id"]
       
    }
    
    func socketRepresentation() -> SocketData {
        return ["room": room,
                "message": message,
                "user_first_id": user_first_id,
                "images": images,
                "sender":sender,
                "user_second_id":user_second_id
                ]
    }
}
