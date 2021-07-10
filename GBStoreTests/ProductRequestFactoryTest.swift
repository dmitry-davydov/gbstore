//
//  ProductRequestFactoryTest.swift
//  GBStoreTests
//
//  Created by Дима Давыдов on 26.06.2021.
//

import XCTest
@testable import GBStore

class ProductRequestFactoryTest: XCTestCase {

    var requestFactory: RequestFactory?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        requestFactory = RequestFactory()
    }

    override func tearDownWithError() throws {
        try super.setUpWithError()
        requestFactory = nil
    }
    
    func getProductRequestFactory() -> ProductRequestFactory {
        XCTAssertNotNil(requestFactory)
        
        return try! XCTUnwrap(requestFactory).makeProductRequestFactory()
    }

    func testAllProducts() {
        let expectation = expectation(description: "All Products")
        let product = getProductRequestFactory()
        let requestModel = ProductCollectionRequest(categoryId: 1, page: 1)
        product.all(model: requestModel) { response in
            switch response.result {
            case .success(_):
                expectation.fulfill()
                break
            case .failure(let err):
                XCTFail(err.localizedDescription)
            }
        }
        
        waitForExpectations(timeout: 10)
    }
    
    func testOneProduct() {
        let expectation = expectation(description: "One Product")
        let product = getProductRequestFactory()
        
        product.one(id: 123) { response in
            switch response.result {
            case .success(_):
                expectation.fulfill()
                break
            case .failure(let err):
                XCTFail(err.localizedDescription)
            }
        }
        
        waitForExpectations(timeout: 10)
    }
}
