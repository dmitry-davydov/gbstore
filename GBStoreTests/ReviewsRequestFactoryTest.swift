//
//  ReviewsRequestFactoryTest.swift
//  GBStoreTests
//
//  Created by Дима Давыдов on 03.07.2021.
//

import Foundation
import XCTest
@testable import GBStore

class ReviewsRequestFactoryTest: XCTestCase {
    var requestFactory: RequestFactory?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        requestFactory = RequestFactory()
    }

    override func tearDownWithError() throws {
        try super.setUpWithError()
        requestFactory = nil
    }
    
    func getReviewsRequestFactory() -> ReviewsRequestFactory {
        XCTAssertNotNil(requestFactory)
        
        return try! XCTUnwrap(requestFactory).makeReviewsRequestFavotory()
    }
    
    func testCreateReview() {
        let expectation = expectation(description: "Create review")
        let reviews = getReviewsRequestFactory()
        reviews.create(model: CreateReviewModel(userId: 1, text: "hui", productId: 1)) { response in
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
    
    func testApproveReview() {
        let expectation = expectation(description: "Approve review")
        let reviews = getReviewsRequestFactory()
        reviews.approve(commentId: 1) { response in
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
    
    func testDeleteReview() {
        let expectation = expectation(description: "Delete review")
        let reviews = getReviewsRequestFactory()
        reviews.delete(commentId: 1) { response in
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
    
    func testReviewList() {
        let expectation = expectation(description: "List review")
        let reviews = getReviewsRequestFactory()
        reviews.list(page: 0) { response in
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
