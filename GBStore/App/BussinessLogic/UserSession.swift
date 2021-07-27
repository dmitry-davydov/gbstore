//
//  UserSession.swift
//  GBStore
//
//  Created by Дима Давыдов on 18.07.2021.
//

import Foundation

enum UserSessionState {
    case unauthorized
    case authorizes
}

class UserSession {
    static let shared = UserSession()
    
    var user: UserResponse?
    var authToken: String?
    
    private(set) var state: UserSessionState = .unauthorized
    
    private init(){}
    
    func setUser(loginResponse: LoginResponse) {
        user = loginResponse.user
        authToken = loginResponse.authToken
        state = .authorizes
    }
}
