//
//  Transport.swift
//  Bars
//
//  Created by Ахмед Фокичев on 30.09.2020.
//

import Foundation

class  Transport {
    var id: String
    var name: String
    var eye: Bool
    var checked: Bool
    var detail: Bool
    var position: Position
    
    init(transportModel: TransportModel) {
        id = transportModel.id
        detail = transportModel.detail
        eye = transportModel.eye
        checked = transportModel.checked
        name = transportModel.name
        position = Position(positionModel: transportModel.positionModel!)
    }
}
