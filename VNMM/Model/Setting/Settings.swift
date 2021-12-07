//
//  Settings.swift
//  Techres - Bán hàng
//
//  Created by Kelvin on 8/21/19.
//  Copyright © 2019 vn.printstudio.res.employee. All rights reserved.
//

import UIKit
import ObjectMapper
class Settings: Mappable {
    var is_working_offline: Int = 0
    var branch_type: Int = 0
    var branch_type_name: String = ""
    var open_time: String?
    var close_Time: String = ""
    var hour_to_take_report: Int = 3
    var api_prefix_path_for_branch_type: String = ""
   
    
    
    init() {}
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    
    func mapping(map: Map){
        is_working_offline              <- map["is_working_offline"]
        branch_type       <- map["branch_type"]
        branch_type_name       <- map["branch_type_name"]
        open_time       <- map["open_time"]
        close_Time              <- map["close_Time"]
        hour_to_take_report              <- map["hour_to_take_report"]
        api_prefix_path_for_branch_type       <- map["api_prefix_path_for_branch_type"]
        
    }
}
