//
//  URLs.swift
//  Bars
//
//  Created by Ахмед Фокичев on 30.09.2020.
//

import Foundation

struct URLs {
    
    static let host =  "https://test.globars.ru"
    static let authUrl = host + "/auth/login"
    static let sessionsUrl = host + "/api/tracking/sessions"
    
    static func unitsUrl(sessionId: String) -> String {
        return host + "/tracking/" + sessionId + "/units"
    }
}
