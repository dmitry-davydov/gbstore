//
//  UpdateUserResponse.swift
//  GBStore
//
//  Created by Дима Давыдов on 25.06.2021.
//

import Foundation

struct UpdateUserResponse: Codable {
    let result: Int
    let errorMessage: String?
}
