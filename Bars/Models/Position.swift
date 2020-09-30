//
//  Position.swift
//  Bars
//
//  Created by Ахмед Фокичев on 30.09.2020.
//

import Foundation
import CoreLocation

class Position {
    
    var location = CLLocationCoordinate2D(latitude: 0, longitude: 0)

    init(positionModel: PositionModel) {
        location = CLLocationCoordinate2D(latitude: positionModel.lt, longitude: positionModel.ln)
    }
}
