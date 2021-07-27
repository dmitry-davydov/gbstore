//
//  BasketRequestFactory.swift
//  GBStore
//
//  Created by Дима Давыдов on 06.07.2021.
//

import Foundation
import Alamofire

// MARK: - BasketRequestFactory Protocol
protocol BasketRequestFactory {
    func add(productID: ProductID, quantity: UInt, completionHandler: @escaping(AFDataResponse<ResultResponse>) -> Void)
    func remove(productID: ProductID, completionHandler: @escaping(AFDataResponse<ResultResponse>) -> Void)
}

// MARK: - AbstractRequestFactory implementation
class Basket: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl: String
    
    init(errorParser: AbstractErrorParser, sessionManager: Session, queue: DispatchQueue = DispatchQueue.global(qos: .utility), configurtation: Configuration) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
        self.baseUrl = configurtation.baseURL
    }
}

// MARK: - BasketRequestFactory implementation
extension Basket: BasketRequestFactory {
    func add(productID: ProductID, quantity: UInt, completionHandler: @escaping(AFDataResponse<ResultResponse>) -> Void) {
        let requestModel = BasketAddRequest(baseUrl: baseUrl, productID: productID, quantity: quantity)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func remove(productID: ProductID, completionHandler: @escaping(AFDataResponse<ResultResponse>) -> Void) {
        let requestModel = BasketRemoveRequest(baseUrl: baseUrl, productID: productID)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

// MARK: - Basket request models
extension Basket {
    struct BasketAddRequest: RequestRouter {
        let baseUrl: String
        let method: HTTPMethod = .post
        let path: String = "basket/add"
        
        let productID: ProductID
        let quantity: UInt
        
        var parameters: Parameters? {
            return [
                "id_product": productID,
                "quantity": quantity
            ]
        }
    }
    
    struct BasketRemoveRequest: RequestRouter {
        let baseUrl: String
        let method: HTTPMethod = .post
        let path: String = "basket/remove"
        
        let productID: ProductID
        
        var parameters: Parameters? {
            return [
                "id_product": productID,
            ]
        }
    }
}
