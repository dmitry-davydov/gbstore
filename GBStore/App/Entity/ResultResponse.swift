//
//  ResultResponse.swift
//  GBStore
//
//  Created by Дима Давыдов on 02.07.2021.
//

import Foundation

struct ResultResponse: Codable {
    let result: Int
    let userMessage: String?
    let errorMessage: String?
}
