//
//  UserAccount.swift
//  VNMM
//
//  Created by Nguyen Tan Dung on 05/04/21.
//

import Foundation
import ObjectMapper

class UserAccount: Mappable {
    var first_name = ""
    var last_name = ""
    var _id = ""
    var gender = 0
    var address = ""
    var email = ""
    var count_post = 0
    
    var avatar = ""
    
    
    init() {}
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map){
        _id                                          <- map["_id"]
        first_name                                <- map["first_name"]
        last_name                                      <- map["last_name"]
        
        gender                                      <- map["gender"]
        address                                       <- map["address"]
        count_post                                        <- map["count_post"]
        email                                        <- map["email"]
        avatar                                        <- map["avatar"]
    }
}

