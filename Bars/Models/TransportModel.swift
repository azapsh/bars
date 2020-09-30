//
//  TransportModel.swift
//  Bars
//
//  Created by Ахмед Фокичев on 30.09.2020.
//

import Foundation
import ObjectMapper

class TransportModel: Mappable {
    
    var id = ""
    var eye = false
    var checked = false
    var detail = false
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        eye <- map["eye"]
        checked <- map["checked"]
        detail <- map["detail"]
    }
}
