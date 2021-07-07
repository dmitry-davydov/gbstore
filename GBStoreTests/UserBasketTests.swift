//
//  UserBasketTests.swift
//  GBStoreTests
//
//  Created by Дима Давыдов on 06.07.2021.
//

import XCTest
@testable import GBStore

class UserBasketTests: XCTestCase {

    var basket: UserBasketProtocol?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        basket = UserBasket()
    }

    override func tearDownWithError() throws {
        try super.setUpWithError()
        basket = nil
    }
    
    func getBasket() -> UserBasketProtocol {
        XCTAssertNotNil(basket)
        
        return try! XCTUnwrap(basket)
    }
    
    func testAddProduct() {
        let basket = getBasket()
        basket.add(product: ProductResponse(result: 1, name: "Product", price: 100500, description: "Product description"))
        
        if basket.products.count == 0 {
            XCTFail("Basket add failed")
        }
    }
    
    func testPay() {
        let basket = getBasket()
        basket.add(product: ProductResponse(result: 1, name: "Product", price: 100500, description: "Product description"))
        basket.pay()
        if basket.products.count > 0 {
            XCTFail("Basket pay failed")
        }
    }
}
