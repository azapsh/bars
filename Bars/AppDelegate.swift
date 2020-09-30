//
//  AppDelegate.swift
//  Bars
//
//  Created by Ахмед Фокичев on 28.09.2020.
//

import UIKit
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        GMSServices.provideAPIKey(Config.googleMapsApiKey)
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate, let window = appDelegate.window  {
            let viewController = AuthViewController()
            let router = AuthViewRouter(view: viewController)
            let authViewModel = AuthViewModel()
            authViewModel.router = router
            viewController.viewModel = authViewModel
            
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.setNavigationBarHidden(true, animated: false)
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
        
        return true
    }

    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Registration(google firebase) failed!")
    }

}
