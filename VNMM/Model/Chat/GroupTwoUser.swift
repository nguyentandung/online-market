//
//  GroupTwoUser.swift
//  VNMM
//
//  Created by Nguyen Tan Dung on 05/05/21.
//

import Foundation
import ObjectMapper

class GroupTwoUser: Mappable {
    
    
    var user_second_id = ""
    var _id = ""
    var user_first_id = ""
    var room_name = ""
    
    init() {}
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map){
        user_second_id                                       <- map["user_second_id"]
        _id                                          <- map["_id"]
        user_first_id                                        <- map["user_first_id"]
        room_name                                        <- map["room_name"]

    }
}
