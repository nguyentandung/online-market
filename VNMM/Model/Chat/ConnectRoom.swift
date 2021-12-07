//
//  ConnectRoom.swift
//  VNMM
//
//  Created by Nguyen Tan Dung on 05/06/21.
//

import Foundation
import ObjectMapper
import SocketIO

class ConnectRoom: Mappable, SocketData {

    var userFirstId = ""
    
    var userSecondId = ""
    var room = ""
    var messages = ""
   
    
    init() {}
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        userFirstId                                         <- map["userFirstId"]
        userSecondId                                         <- map["userSecondId"]
        room                                         <- map["room"]
        messages                                         <- map["messages"]
        
    }
    
    func socketRepresentation() -> SocketData {
           return ["userFirstId": userFirstId,
                   "userSecondId": userSecondId,
                   "room": room,
                   "messages": messages]
       }
}
