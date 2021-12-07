//
//  RequestCallAPI.swift
//  ALOLINE
//
//  Created by Kelvin on 4/1/21.
//  Copyright © 2021 aloapp. All rights reserved.
//

import UIKit
import ObjectMapper

class RequestCallAPI: Mappable {
    var params = NSDictionary()
    var server_url = ""
    var http_method = 0
       
       init() {}
       
       required  init?(map: Map) {
           mapping(map: map)
       }
       
       
       func mapping(map: Map) {
        params       <- map["params"]
        server_url       <- map["server_url"]
        http_method       <- map["http_method"]
           
       }
}
