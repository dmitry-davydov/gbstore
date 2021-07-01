//
//  UserRequestFactoryTest.swift
//  GBStoreTests
//
//  Created by Дима Давыдов on 26.06.2021.
//

import XCTest
import Alamofire
@testable import GBStore

class UserRequestFactoryTest: XCTestCase {
    
    var requestFactory: RequestFactory?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        requestFactory = RequestFactory()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        requestFactory = nil
    }
    
    func getUserRequestFactory() -> UserRequestFactory {
        XCTAssertNotNil(requestFactory)
        
        return try! XCTUnwrap(requestFactory).makeUserRequestFatory()
    }
    
    func testLogin() {
        let expectation = expectation(description: "Login")
        
        let user = getUserRequestFactory()
        user.login(model: LoginRequest(userName: "test", password: "test"), completionHandler: { response in
            switch response.result {
            case .success(_):
                expectation.fulfill()
                break
            case .failure(let err):
                XCTFail(err.localizedDescription)
            }
        })
        
        waitForExpectations(timeout: 10)
    }
    
    func testLogout() {
        let expectation = expectation(description: "Logout")
        let user = getUserRequestFactory()
        
        user.logout(userId: 123) { response in
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
    
    func testCreateUser() {
        let expectation = expectation(description: "CreateUser")
        let user = getUserRequestFactory()
        user.create(model: CreateUserRequest(username: "username", password: "password", email: "email", gender: .female, creditCard: "card", bio: "bio")) { response in
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
    
    func testUpdateUser() {
        let expectation = expectation(description: "UpdateUser")
        let user = getUserRequestFactory()
        user.update(model: UpdateUserRequest(id: 1, username: "username", password: "password", email: "email", gender: .male, creditCard: "card", bio: "bio")) { response in
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
