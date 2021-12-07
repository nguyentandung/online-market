//
//  Account.swift
//  GS_iOS
//
//  Created by kelvin on 11/7/18.
//  Copyright © 2018 vn.eteacher. All rights reserved.
//

import UIKit
import ObjectMapper

class Account: Mappable {
    var first_name = ""
    var last_name = ""
    var _id = ""
    var phone = ""
    var gender = 0
    var address = ""
    var password = ""
    var email = ""
    var accessToken = ""
    
    //local
    var isSelect = 0
    
    init() {}
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map){
        _id                                          <- map["_id"]
        first_name                                <- map["first_name"]
        last_name                                      <- map["last_name"]
        phone                               <- map["phone"]
        gender                                      <- map["gender"]
        address                                       <- map["address"]
        password                                        <- map["password"]
        email                                        <- map["email"]
        accessToken                                        <- map["accessToken"]
    }
}
