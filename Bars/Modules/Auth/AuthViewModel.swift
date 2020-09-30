//
//  AuthViewModel.swift
//  Bars
//
//  Created by Ахмед Фокичев on 28.09.2020.
//

import Foundation
import SVProgressHUD

protocol AuthViewModelProtocol: AnyObject {
    func tapButtonEntry(login: String, password: String)
}

class AuthViewModel: AuthViewModelProtocol {
    
    let authService = AuthService()
    var router: AuthViewRouterProtocol?
    
    func tapButtonEntry(login: String, password: String) {
        authService.logIn(login: login, password: password) { [ weak self] (success, error) in
            SVProgressHUD.dismiss()
            
            if success {
                
            }
            
            self?.router?.showMap()
        }
    }
    
    
}
