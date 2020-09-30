//
//  Session.swift
//  Bars
//
//  Created by Ахмед Фокичев on 30.09.2020.
//

import Foundation

class Session {
    
    var id = ""
    var transports = [Transport]()
    
    init(sessionModel: SessionModel) {
        id = sessionModel.id
        for obj in sessionModel.units {
            let transport = Transport(transportModel: obj)
            transports.append(transport)
        }
    }
}
