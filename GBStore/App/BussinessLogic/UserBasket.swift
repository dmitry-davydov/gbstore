//
//  UserBasket.swift
//  GBStore
//
//  Created by Дима Давыдов on 06.07.2021.
//

import Foundation

// MARK: - UserBasketProtocol
protocol UserBasketProtocol {
    var products: [ProductResponse] { get }
    
    func pay()
    func add(product: ProductResponse)
}

// MARK: - UserBasket class
class UserBasket {
    private(set) var products: [ProductResponse] = []
}

// MARK: - UserBasketProtocol implementation
extension UserBasket: UserBasketProtocol {
    func pay() {
        products = []
    }
    
    func add(product: ProductResponse) {
        products.append(product)
    }
}
