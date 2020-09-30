//
//  SessionModel.swift
//  Bars
//
//  Created by Ахмед Фокичев on 30.09.2020.
//

import Foundation
import ObjectMapper

class SessionModel: Mappable {
    
    var id = ""
    var units = [TransportModel]()
    var createdAt = ""
    var updatedAt = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        units <- map["units"]
        createdAt <- map["createdAt"]
        updatedAt <- map["updatedAt"]
    }
}
