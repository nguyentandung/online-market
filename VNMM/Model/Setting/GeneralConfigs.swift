//
//  GeneralConfigs.swift
//  GS_iOS
//
//  Created by kelvin on 11/7/18.
//  Copyright © 2018 vn.eteacher. All rights reserved.
//

import UIKit
import ObjectMapper

class GeneralConfigs: Mappable {
    var api_domain: String = ""
    var domain_name: String = ""
    var restaurant_logo: String = ""
     var restaurant_name: String?
     var restaurant_color: String = ""
     var is_apply_discount: String = ""
     var api_key: String = ""
     var type: String = ""
    var firebase : String = ""
    var install_app_url: String = ""
    var version:Int = 1
    var realtime_domain = ""
    
    var ads_domain: String = ""
    var chat_domain: String = ""
    var current_domain: String = ""
    var date_time: String = ""
    var system_server: String = ""
    
    
    init() {}
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    
    func mapping(map: Map){
        api_key                     <- map["api_key"]
        type                        <- map["type"]
        firebase                    <- map["firebase"]
        version                     <- map["version"]
        
        api_domain              <- map["api_domain"]
        domain_name              <- map["restaurant_domain"]
        restaurant_logo       <- map["restaurant_logo"]
        restaurant_name       <- map["restaurant_name"]
        restaurant_color       <- map["restaurant_color"]
        is_apply_discount       <- map["is_apply_discount"]
        install_app_url       <- map["install_app_url"]
        realtime_domain       <- map["realtime_domain"]
        
        ads_domain       <- map["ads_domain"]
        chat_domain       <- map["chat_domain"]
        current_domain       <- map["current_domain"]
        date_time       <- map["date_time"]
        system_server       <- map["system_server"]
        
    }
}
