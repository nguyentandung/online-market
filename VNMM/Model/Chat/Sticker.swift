//
//  Sticker.swift
//  VNMM
//
//  Created by Nguyen Tan Dung on 05/11/21.
//

import UIKit
import ObjectMapper

class Sticker: Mappable {
    var name = ""
    var link_original = ""
    var id_category = ""
    
    
    init() {}
    
    required  init?(map: Map) {
        mapping(map: map)
    }
    
    func  mapping(map: Map) {
        name    <- map["name"]
        link_original    <- map["link_original"]
        id_category    <- map["id_category"]
       
    }
}

