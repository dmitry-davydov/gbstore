//
//  ProductRequestFactory.swift
//  GBStore
//
//  Created by Дима Давыдов on 26.06.2021.
//

import Foundation
import Alamofire

protocol ProductRequestFactory {
    func all(model: ProductCollectionRequest, completionHandler: @escaping(AFDataResponse<ProductListResponse>) -> Void)
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
    func all(model: ProductCollectionRequest, completionHandler: @escaping (AFDataResponse<ProductListResponse>) -> Void) {
        let requestModel = AllRequest(baseUrl: baseUrl, model: model)
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
        
        let model: ProductCollectionRequest
        
        var parameters: Parameters? {
            return [
                "page_number": model.page,
                "id_category": model.categoryId
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
