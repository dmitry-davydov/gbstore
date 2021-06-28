//
//  CreateUserResponse.swift
//  GBStore
//
//  Created by Дима Давыдов on 25.06.2021.
//

import Foundation

struct CreateUserResponse: Codable {
    let result: Int
    let userMessage: String?
    let errorMessage: String?
}
