//
//  Version.swift
//  techres
//
//  Created by kelvin on 11/28/18.
//  Copyright © 2018 vn.aloapp. All rights reserved.
//

import UIKit
import ObjectMapper

class Version: Mappable {

    var id:Int?
    var version:String?
    var message:String?
    var message_en:String?
    var is_require_update:Int?
    
    init() {}
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map){
        id <- map["id"]
        version <- map["version"]
        message <- map["message"]
        message_en <- map["message_en"]
        is_require_update <- map["is_require_update"]
    }
}
