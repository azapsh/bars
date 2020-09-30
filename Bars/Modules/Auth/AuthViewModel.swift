//
//  AuthViewModel.swift
//  Bars
//
//  Created by Ахмед Фокичев on 28.09.2020.
//

import Foundation
import SVProgressHUD
import RxSwift
import RxRelay


protocol AuthViewModelProtocol: AnyObject {
    func tapButtonEntry(login: String, password: String)
    var authError: BehaviorRelay <String> { get }
}

class AuthViewModel: AuthViewModelProtocol {
    
    let authService = AuthService()
    var router: AuthViewRouterProtocol?
    let authError = BehaviorRelay<String>(value: "")
    
    func tapButtonEntry(login: String, password: String) {
        authService.logIn(login: login, password: password) { [ weak self] (success, error) in
            SVProgressHUD.dismiss()
            if success {
                self?.getSessionId()
            } else {
                self?.authError.accept(error)
            }
        }
    }
    
    func getSessionId() {
        let accessToken = TokensService.shared.accessToken
        
        authService.getSessionID(accessToken: accessToken) { [ weak self] (success, error) in
            if success {
                print("TokensService.shared.sessionId>",TokensService.shared.sessionId)
                self?.router?.showMap()
            } else {
                self?.authError.accept(error)
            }
        }
        
    }
    
}
