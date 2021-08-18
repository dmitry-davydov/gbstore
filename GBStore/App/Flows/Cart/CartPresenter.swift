//
//  CartPresenter.swift
//  GBStore
//
//  Created by Дима Давыдов on 24.07.2021.
//

import UIKit

// MARK: - Presenter protocols
protocol CartViewInput {

}

protocol CartViewOutput {
    func buyButtonPressed()
}

// MARK: - Presenter
class CartPresenter {
    weak var viewInput: (UIViewController & CartViewInput)?
    
    var userBasketService: UserBasketProtocol {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
              let userBasket = appDelegate.container.resolve(UserBasketProtocol.self) else {
            fatalError("Can not resolve container")
        }
        
        return userBasket
    }
}

// MARK: - ViewOutput implementation for presenter
extension CartPresenter: CartViewOutput {
    func buyButtonPressed() {
        userBasketService.pay()
    }
}
