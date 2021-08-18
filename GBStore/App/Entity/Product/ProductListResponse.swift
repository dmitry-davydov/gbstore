//
//  ProductListResponse.swift
//  GBStore
//
//  Created by Дима Давыдов on 26.06.2021.
//

import Foundation

typealias ProductID = Int

struct ProductListItem: Codable {
    let id: ProductID
    let name: String
    let price: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "id_product"
        case name = "product_name"
        case price = "price"
    }
}

struct ProductListResponse: Codable {
    let products: [ProductListItem]
    let page_number: Int
}
