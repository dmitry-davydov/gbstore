//
//  LoginResult.swift
//  GBStore
//
//  Created by Дима Давыдов on 24.06.2021.
//

import Foundation

struct LoginResult: Codable {
    let result: Int
    let user: User
    let authToken: String
}
