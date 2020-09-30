//
//  PositionModel.swift
//  Bars
//
//  Created by Ахмед Фокичев on 30.09.2020.
//

import Foundation

import ObjectMapper

class PositionModel: Mappable {
    
    var i = false
    var m = 0
    var u = ""
    var lt: Double = 0
    var ln: Double = 0
    var s = 0
    var t = 0
    var b = 0
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        i <- map["i"]
        m <- map["m"]
        u <- map["u"]
        lt <- map["lt"]
        ln <- map["ln"]
        s <- map["s"]
        t <- map["t"]
        b <- map["b"]
    }
}
