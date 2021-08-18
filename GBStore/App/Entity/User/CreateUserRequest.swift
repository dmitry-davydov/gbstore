//
//  CreateUserRequest.swift
//  GBStore
//
//  Created by Дима Давыдов on 25.06.2021.
//

import Foundation

struct CreateUserRequest {
    let username: String
    let password: String
    let email: String
    let gender: UserGender
    let creditCard: String
    let bio: String
}
