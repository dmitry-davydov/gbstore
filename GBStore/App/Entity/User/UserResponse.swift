//
//  User.swift
//  GBStore
//
//  Created by Дима Давыдов on 24.06.2021.
//

import Foundation

enum UserGender: String {
    case male = "m"
    case female = "g"
}

struct UserResponse: Codable {
    let id: Int
    let login: String
    let name: String
    let lastname: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id_user"
        case login = "user_login"
        case name = "user_name"
        case lastname = "user_lastname"
    }
}
