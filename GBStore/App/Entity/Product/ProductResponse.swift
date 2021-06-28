//
//  ProductResponse.swift
//  GBStore
//
//  Created by Дима Давыдов on 26.06.2021.
//

import Foundation

struct ProductResponse: Codable {
    let result: Int
    let name: String
    let price: Int
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case result = "result"
        case name = "product_name"
        case price = "product_price"
        case description = "product_description"
    }
}
