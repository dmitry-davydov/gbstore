//
//  ViewController.swift
//  GBStore
//
//  Created by Дима Давыдов on 01.07.2021.
//

import UIKit

class ViewController: UIViewController {
    
    let requestFactory = RequestFactory()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        let userRequestFactory = requestFactory.makeUserRequestFatory()
        let productRequestFactory = requestFactory.makeProductRequestFactory()
        let reviewsRequestFatory = requestFactory.makeReviewsRequestFavotory()
        
        userCreate(userRequestFactory: userRequestFactory)
        userUpdate(userRequestFactory: userRequestFactory)
        userLogin(userRequestFactory: userRequestFactory)
        userLogout(userRequestFactory: userRequestFactory)
        
        productAll(productRequestFactory: productRequestFactory)
        productOne(productRequestFactory: productRequestFactory)
        
        reviewCreate(requestFactory: reviewsRequestFatory)
        reviewList(requestFactory: reviewsRequestFatory)
        reviewAppove(requestFactory: reviewsRequestFatory)
        reviewDelete(requestFactory: reviewsRequestFatory)
    }
    
    func userCreate(userRequestFactory: UserRequestFactory) {
        // registration
        userRequestFactory.create(model: CreateUserRequest(
                                    username: "username",
                                    password: "pass",
                                    email: "user@example.com",
                                    gender: .male,
                                    creditCard: "0000-0000-0000-0000",
                                    bio: "Funny guy")
        ) { response in
            switch response.result {
            case .success(let user):
                print(user)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func userUpdate(userRequestFactory: UserRequestFactory) {
        userRequestFactory.update(model: UpdateUserRequest(
                                    id: 123,
                                    username: "username1",
                                    password: "password1",
                                    email: "user1@example.com",
                                    gender: .female,
                                    creditCard: "1111-1111-1111-1111",
                                    bio: "Funny girl")
        ) { response in
            switch response.result {
            case .success(let user):
                print(user)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func userLogin(userRequestFactory: UserRequestFactory) {
        userRequestFactory.login(model: LoginRequest(userName: "username", password: "password")) { response in
            switch response.result {
            case .success(let login):
                print(login)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func userLogout(userRequestFactory: UserRequestFactory) {
        userRequestFactory.logout(userId: 123, completionHandler: { response in
            switch response.result {
            case .success(let logout):
                print(logout)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
        
    }
    
    func productAll(productRequestFactory: ProductRequestFactory) {
        productRequestFactory.all(page: 0, categoryId: 1) { response in
            switch response.result {
            case .success(let productList):
                print(productList)
                break
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    func productOne(productRequestFactory: ProductRequestFactory) {
        productRequestFactory.one(id: 123) { response in
            switch response.result {
            case .success(let product):
                print(product)
                break
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func reviewCreate(requestFactory: ReviewsRequestFactory) {
        requestFactory.create(model: CreateReviewModel(userId: 1, text: "hui", productId: 1)) { response in
            switch response.result {
            case .success(let response):
                print(response)
                break
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func reviewDelete(requestFactory: ReviewsRequestFactory) {
        requestFactory.delete(commentId: 1) { response in
            switch response.result {
            case .success(let response):
                print(response)
                break
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func reviewList(requestFactory: ReviewsRequestFactory) {
        requestFactory.list(page: 0) { response in
            switch response.result {
            case .success(let response):
                print(response)
                break
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func reviewAppove(requestFactory: ReviewsRequestFactory) {
        requestFactory.approve(commentId: 1) { response in
            switch response.result {
            case .success(let response):
                print(response)
                break
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
