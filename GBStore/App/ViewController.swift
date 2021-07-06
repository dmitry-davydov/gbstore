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
        let basketRequestFactory = requestFactory.makeBasketRequestFactory()
        
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
        
        addBasket(requestFactory: basketRequestFactory)
        removeBasket(requestFactory: basketRequestFactory)
    }
    
    // MARK: - user methods
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
            print("User create")
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
            print("User update")
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
            print("User login")
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
            print("User logout")
            switch response.result {
            case .success(let logout):
                print(logout)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
        
    }
    
    // MARK: - Product methods
    func productAll(productRequestFactory: ProductRequestFactory) {
        productRequestFactory.all(page: 0, categoryId: 1) { response in
            print("All products")
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
            print("One product")
            switch response.result {
            case .success(let product):
                print(product)
                break
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    // MARK: - Review methods
    func reviewCreate(requestFactory: ReviewsRequestFactory) {
        requestFactory.create(model: CreateReviewModel(userId: 1, text: "hui", productId: 1)) { response in
            print("Review create")
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
            print("Review delete")
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
            print("Review list")
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
            print("Review approve")
            switch response.result {
            case .success(let response):
                print(response)
                break
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    // MARK: - Basket methods
    func addBasket(requestFactory: BasketRequestFactory) {
        requestFactory.add(productID: 1, quantity: 1) { response in
            print("Basket add")
            switch response.result {
            case .success(let response):
                print(response)
                break
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    func removeBasket(requestFactory: BasketRequestFactory) {
        requestFactory.remove(productID: 1) { response in
            print("Basket remove")
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
