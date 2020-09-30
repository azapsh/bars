//
//  MapViewModel.swift
//  Bars
//
//  Created by Ахмед Фокичев on 28.09.2020.
//

import Foundation
import SVProgressHUD
import RxRelay

protocol MapViewModelProtocol: AnyObject {
    func loadTransports()
    var rxTransports: BehaviorRelay<[Transport]> { get }
    var transports: [Transport] { get }
}

class MapViewModel: MapViewModelProtocol {
    
    var router: MapViewRouterProtocol?
    let transportService = TransportService()
    let rxTransports = BehaviorRelay<[Transport]>(value: [Transport]())
    var transports = [Transport]()
    
    func loadTransports() {
        let sessinId = TokensService.shared.sessionId
        let accessToken = TokensService.shared.accessToken
        
        transportService.getUnits(accessToken: accessToken, sessinId: sessinId) { [ weak self] ( list, success, error)  in
            self?.transports = list
            self?.rxTransports.accept(list)
        }
    }
    
}

