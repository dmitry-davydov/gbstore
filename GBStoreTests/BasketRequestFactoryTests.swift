//
//  BasketRequestFactoryTests.swift
//  GBStoreTests
//
//  Created by Дима Давыдов on 06.07.2021.
//

import XCTest
@testable import GBStore

class BasketRequestFactoryTests: XCTestCase {

    var requestFactory: RequestFactory?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        requestFactory = RequestFactory()
    }

    override func tearDownWithError() throws {
        try super.setUpWithError()
        requestFactory = nil
    }
    
    func getRequestFactory() -> BasketRequestFactory {
        XCTAssertNotNil(requestFactory)
        
        return try! XCTUnwrap(requestFactory).makeBasketRequestFactory()
    }
    
    func testAdd() {
        let expectation = expectation(description: "Add to basket")
        let reviews = getRequestFactory()
        reviews.add(productID: 1, quantity: 1, completionHandler: { response in
            switch response.result {
            case .success(_):
                expectation.fulfill()
                break
            case .failure(let err):
                XCTFail(err.localizedDescription)
            }
        })
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testRemove() {
        let expectation = expectation(description: "Remove from basket")
        let reviews = getRequestFactory()
        reviews.remove(productID: 1, completionHandler: { response in
            switch response.result {
            case .success(_):
                expectation.fulfill()
                break
            case .failure(let err):
                XCTFail(err.localizedDescription)
            }
        })
        
        wait(for: [expectation], timeout: 10)
    }

}
