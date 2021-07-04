//
//  ProductRequestFactory.swift
//  GBStore
//
//  Created by Дима Давыдов on 26.06.2021.
//

import Foundation
import Alamofire

protocol ProductRequestFactory {
    func all(page: Int, categoryId: Int, completionHandler: @escaping(AFDataResponse<ProductListResponse>) -> Void)
    func one(id: ProductID, completionHandler: @escaping(AFDataResponse<ProductResponse>) -> Void)
    
}

class Product: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl: URL
    
    init(errorParser: AbstractErrorParser, sessionManager: Session, queue: DispatchQueue = DispatchQueue.global(qos: .utility), configurtation: Configuration) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
        self.baseUrl = configurtation.baseURL
    }
}

extension Product: ProductRequestFactory {
    func all(page: Int = 0, categoryId: Int, completionHandler: @escaping (AFDataResponse<ProductListResponse>) -> Void) {
        let requestModel = AllRequest(baseUrl: baseUrl, page: page, categoryId: categoryId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func one(id: ProductID, completionHandler: @escaping (AFDataResponse<ProductResponse>) -> Void) {
        let requestModel = ProductRequest(baseUrl: baseUrl, productId: id)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Product {
    struct AllRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "product/all"
        
        let page: Int
        let categoryId: Int
        
        var parameters: Parameters? {
            return [
                "page_number": page,
                "id_category": categoryId
            ]
        }
    }
    
    struct ProductRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "product/one"
        
        let productId: ProductID
        
        var parameters: Parameters? {
            return [
                "id_product": productId,
            ]
        }
    }
}
