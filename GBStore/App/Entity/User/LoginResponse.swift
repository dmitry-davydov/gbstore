//
//  LoginResponse.swift
//  GBStore
//
//  Created by Дима Давыдов on 24.06.2021.
//

import Foundation

struct LoginResponse: Codable {
    let result: Int
    let user: UserResponse
    let authToken: String
}
