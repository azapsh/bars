//
//  AuthViewRouter.swift
//  Bars
//
//  Created by Ахмед Фокичев on 28.09.2020.
//

import Foundation
import UIKit

protocol AuthViewRouterProtocol: class {
    func showMap()
}

final class AuthViewRouter: AuthViewRouterProtocol {
    
    // MARK: Properties
    weak var view: AuthViewController?
    
    init(view: AuthViewController) {
        self.view = view
    }
    
    
    func  showMap() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate, let window = appDelegate.window  {
            
            let viewController = MapViewController()
            let router = MapViewRouter(view: viewController)
            let viewModel = MapViewModel()
            viewModel.router = router
            viewController.viewModel = viewModel
            let nc = UINavigationController(rootViewController: viewController)
            nc.setNavigationBarHidden(true, animated: false)
            window.rootViewController = nc
            window.makeKeyAndVisible()
        }
    }
}
