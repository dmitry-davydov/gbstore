//
//  UserBasket.swift
//  GBStore
//
//  Created by Дима Давыдов on 06.07.2021.
//

import Foundation

extension Notification.Name {
    enum Cart {
        static let Add = Notification.Name(rawValue: "cart.add")
        static let Pay = Notification.Name(rawValue: "cart.pay")
    }
}

// MARK: - UserBasketProtocol
protocol UserBasketProtocol {
    var products: [ProductResponse] { get }
    
    func pay()
    func add(product: ProductResponse)
    
    func totalCost() -> Int
    func allProducts() -> [ProductResponse]
}

// MARK: - UserBasket class
class UserBasket {
    private(set) var products: [ProductResponse] = []
}

// MARK: - UserBasketProtocol implementation
extension UserBasket: UserBasketProtocol {
    func allProducts() -> [ProductResponse] {
        return products
    }
    
    func totalCost() -> Int {
        return products.map({ $0.price }).reduce(0, +)
    }
    
    func pay() {
        products = []
        NotificationCenter.default.post(name: Notification.Name.Cart.Pay, object: nil)
    }
    
    func add(product: ProductResponse) {
        products.append(product)
        NotificationCenter.default.post(name: Notification.Name.Cart.Add, object: nil)
    }
}
