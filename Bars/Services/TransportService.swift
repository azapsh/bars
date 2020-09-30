//
//  TransportService.swift
//  Bars
//
//  Created by Ахмед Фокичев on 30.09.2020.
//

import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper

final class TransportService {
    
    func getUnits(accessToken: String, sessinId: String, completion: @escaping ([Transport] , _ success: Bool, _ error: String) -> ()) {
        
        let url = URLs.unitsUrl(sessionId: sessinId)
        let parameters: Parameters = ["": ""]
        var _headers = HTTPHeaders()
        _headers["Authorization"] = "Bearer " + accessToken
        
        print(url)
        AF.request(url, method: .get, parameters: parameters,encoding: URLEncoding.default, headers: _headers)
            .responseJSON { response in
                
                let status = response.response?.statusCode ?? 0
                var transports = [Transport]()
                
                switch response.result {
                case .success(let value):
                    if status == 200 {
                        let json = JSON(value)
                        print(json)
                        if let list = Mapper<TransportModel>().mapArray(JSONObject: json["data"].object) {
                            print("list.count>",list.count)
                            for tsmodel in list {
                                print("tsmodel.name>", tsmodel.name)
                                let transport = Transport(transportModel: tsmodel)
                                if transport.checked {
                                    transports.append(transport)
                                }
                            }
                        }
                        
                        completion(transports, true, String(status))
                    } else {
                        completion(transports, false, String(status))
                    }
                    
                    return
                    
                case .failure(let error):
                    print("error>",error)
                    completion(transports, false, error.localizedDescription)
                    
                    return
                }
            }
    }
}
