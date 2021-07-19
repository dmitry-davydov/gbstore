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
        let requestModel = CreateUserRequest(
            username: "username",
            password: "pass",
            email: "user@example.com",
            gender: .male,
            creditCard: "0000-0000-0000-0000",
            bio: "Funny guy")
        
        print("Create user with data \(requestModel)")
        
        userRequestFactory.create(model: requestModel) { response in
            print("User create")
            switch response.result {
            case .success(let user):
                print("Create user success response with data \(user)")
            case .failure(let error):
                print("Create user error response with \(error.localizedDescription)")
            }
        }
    }
    
    func userUpdate(userRequestFactory: UserRequestFactory) {
        
        let requestModel = UpdateUserRequest(
            id: 123,
            username: "username1",
            password: "password1",
            email: "user1@example.com",
            gender: .female,
            creditCard: "1111-1111-1111-1111",
            bio: "Funny girl")
        
        print("Update user with data: \(requestModel)")
        
        userRequestFactory.update(model: requestModel) { response in
            switch response.result {
            case .success(let user):
                print("Update user success response with data \(user)")
            case .failure(let error):
                print("Update user error response with \(error.localizedDescription)")
            }
        }
    }
    
    func userLogin(userRequestFactory: UserRequestFactory) {
        let requestModel = LoginRequest(userName: "username", password: "password")
        print("User logout request with \(requestModel)")
        userRequestFactory.login(model: requestModel) { response in
            switch response.result {
            case .success(let login):
                print("User logout success response \(login)")
            case .failure(let error):
                print("User logout error response \(error.localizedDescription)")
            }
        }
    }
    
    func userLogout(userRequestFactory: UserRequestFactory) {
        
        let userId = 123
        
        print("Logout user request for user \(userId)")
        
        userRequestFactory.logout(userId: userId, completionHandler: { response in
            switch response.result {
            case .success(let logout):
                print("Logout user success response with data \(logout)")
            case .failure(let error):
                print("Logout user error response with \(error.localizedDescription)")
            }
        })
    }
    
    // MARK: - Product methods
    func productAll(productRequestFactory: ProductRequestFactory) {
        
        let requestModel = ProductCollectionRequest(categoryId: 1, page: 1)
        
        print("Product all request with \(requestModel)")
        
        productRequestFactory.all(model: requestModel) { response in
            switch response.result {
            case .success(let productList):
                print("Product all success response with data \(productList)")
                break
            case .failure(let err):
                print("Product all error response with \(err.localizedDescription)")
            }
        }
    }
    
    func productOne(productRequestFactory: ProductRequestFactory) {
        print("Product one request with productId: 123")
        productRequestFactory.one(id: 123) { response in
            switch response.result {
            case .success(let product):
                print("Product one success response with \(product)")
                break
            case .failure(let err):
                print("Product one error response \(err.localizedDescription)")
            }
        }
    }
    
    // MARK: - Review methods
    func reviewCreate(requestFactory: ReviewsRequestFactory) {
        
        let requestModel = CreateReviewModel(userId: 1, text: "hui", productId: 1)
        print("Create review with data \(requestModel)")
        
        requestFactory.create(model: requestModel) { response in
            switch response.result {
            case .success(let response):
                print("Create review success response \(response)")
                break
            case .failure(let err):
                print("Create review error response \(err.localizedDescription)")
            }
        }
    }
    
    func reviewDelete(requestFactory: ReviewsRequestFactory) {
        print("Delete review with commentId: 1")
        requestFactory.delete(commentId: 1) { response in
            switch response.result {
            case .success(let response):
                print("Delete review success response \(response)")
                break
            case .failure(let err):
                print("Delete review error response \(err.localizedDescription)")
            }
        }
    }
    
    func reviewList(requestFactory: ReviewsRequestFactory) {
        print("Review list with page 0")
        requestFactory.list(page: 0) { response in
            switch response.result {
            case .success(let response):
                print("Review list success response \(response)")
                break
            case .failure(let err):
                print("Review list error response \(err.localizedDescription)")
            }
        }
    }
    
    func reviewAppove(requestFactory: ReviewsRequestFactory) {
        print("Review approve for commentId = 1")
        requestFactory.approve(commentId: 1) { response in
            switch response.result {
            case .success(let response):
                print("Review approve success response \(response)")
                break
            case .failure(let err):
                print("Review approve error response \(err.localizedDescription)")
            }
        }
    }
    
    // MARK: - Basket methods
    func addBasket(requestFactory: BasketRequestFactory) {
        print("Add basket request with productId: 1 and quantity: 1")
        requestFactory.add(productID: 1, quantity: 1) { response in
            
            switch response.result {
            case .success(let response):
                print("Add basket success response \(response)")
                break
            case .failure(let err):
                print("Add basket error response \(err.localizedDescription)")
            }
        }
    }
    
    func removeBasket(requestFactory: BasketRequestFactory) {
        
        print("Remove basket request with productId: 1")
        
        requestFactory.remove(productID: 1) { response in
            switch response.result {
            case .success(let response):
                print("Remove basket success response \(response)")
                break
            case .failure(let err):
                print("Remove basket error response \(err.localizedDescription)")
            }
        }
    }
}
