//
//  MapViewRouter.swift
//  Bars
//
//  Created by Ахмед Фокичев on 28.09.2020.
//

import Foundation

protocol MapViewRouterProtocol: class {

}

final class MapViewRouter: MapViewRouterProtocol {
    
    // MARK: Properties
    weak var view: MapViewController?
    
    init(view: MapViewController) {
        self.view = view
    }
    
}
