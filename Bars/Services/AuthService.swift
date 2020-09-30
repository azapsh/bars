//
//  AuthService.swift
//  Bars
//
//  Created by Ахмед Фокичев on 29.09.2020.
//

import Foundation
import Alamofire
import SwiftyJSON

final class AuthService {
    
    func logIn(login: String, password: String, completion: @escaping ( _ success: Bool, _ error: String) -> ()) {
        
        let url = URLs.authUrl
        let parameters: Parameters = [
            "username" : login,
            "password" : password,
        ]
        let _headers = HTTPHeaders()
        
        AF.request(url, method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: _headers)
            .responseJSON { response in
                
                let status = response.response?.statusCode ?? 0
                
                switch response.result {
                case .success(let value):
                    if status == 200 {
                        let json = JSON(value)
                        print(json)
                        completion( true, String(status))
                    } else {
                        completion( false, String(status))
                    }
                    
                    return
                    
                case .failure(let error):
                    print("error>",error)
                    completion( false, error.localizedDescription)
                    
                    return
                }
            }
    }
    
    func getSessionID(accessToken: String , completion: @escaping ( _ success: Bool, _ error: String) -> ()) {
        
        let url = URLs.sessionsUrl
        let parameters: Parameters = ["" : ""]
        var _headers = HTTPHeaders()
        _headers["Authorization"] = "Bearer " + accessToken
        
        AF.request(url, method: .post, parameters: parameters,encoding: URLEncoding.default, headers: _headers)
            .responseJSON { response in
                
                let status = response.response?.statusCode ?? 0
                
                switch response.result {
                case .success(let value):
                    if status == 200 {
                        let json = JSON(value)
                        print(json)
                        completion( true, String(status))
                    } else {
                        completion( false, String(status))
                    }
                    
                    return
                    
                case .failure(let error):
                    print("error>",error)
                    completion( false, error.localizedDescription)
                    
                    return
                }
            }
    }
    
}
