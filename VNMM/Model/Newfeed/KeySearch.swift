//
//  KeySearch.swift
//  VNMM
//
//  Created by Nguyen Tan Dung on 06/25/21.
//

import UIKit
import ObjectMapper
class KeySearch: Mappable {
    var _id = ""
    var user_id = ""
    var key = ""
    
    init() {}
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    
    func mapping(map: Map){
        _id              <- map["_id"]
        user_id              <- map["user_id"]
        key              <- map["key"]
       
        
    }
}
