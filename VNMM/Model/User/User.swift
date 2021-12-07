//
//  User.swift
//  TechresSupplier
//
//  Created by Nguyen Tan Dung on 04/22/21.
//

import UIKit
import ObjectMapper
class User: Mappable {
    var accessToken = ""
    
    init() {}
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    
    func mapping(map: Map){
        accessToken              <- map["accessToken"]
       
        
    }
}

