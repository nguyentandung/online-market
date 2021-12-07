//
//  ListGroup.swift
//  VNMM
//
//  Created by Nguyen Tan Dung on 05/09/21.
//

import Foundation
import ObjectMapper

class ListGroup: Mappable {
    
    
    var user_second_id = ""
    var _id = ""
    var user_first_id = ""
    var room_name = ""
    var room_avatar = ""
    
    init() {}
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map){
        user_second_id                                       <- map["user_second_id"]
        _id                                          <- map["_id"]
        user_first_id                                        <- map["user_first_id"]
        room_name                                        <- map["room_name"]
        
        room_avatar                                        <- map["room_avatar"]

    }
}

