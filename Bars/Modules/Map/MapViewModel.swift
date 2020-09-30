//
//  MapViewModel.swift
//  Bars
//
//  Created by Ахмед Фокичев on 28.09.2020.
//

import Foundation
import SVProgressHUD

protocol MapViewModelProtocol: AnyObject {
    
}

class MapViewModel: MapViewModelProtocol {
    
    var router: MapViewRouterProtocol?
    
    func loadTransports() {
        
    }
}

