//
//  ReviewsRequestFactory.swift
//  GBStore
//
//  Created by Дима Давыдов on 02.07.2021.
//

import Foundation
import Alamofire

protocol ReviewsRequestFactory {
    func list(page: Int, completionHandler: @escaping(AFDataResponse<ReviewListResponse>) -> Void)
    func create(model: CreateReviewModel, completionHandler: @escaping(AFDataResponse<ResultResponse>) -> Void)
    func delete(commentId: Int, completionHandler: @escaping(AFDataResponse<ResultResponse>) -> Void)
    func approve(commentId: Int, completionHandler: @escaping(AFDataResponse<ResultResponse>) -> Void)
}

class Reviews: AbstractRequestFactory {
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

extension Reviews: ReviewsRequestFactory {
    func list(page: Int, completionHandler: @escaping (AFDataResponse<ReviewListResponse>) -> Void) {
        let requestModel = ListRequest(baseUrl: baseUrl, page: page)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func create(model: CreateReviewModel, completionHandler: @escaping (AFDataResponse<ResultResponse>) -> Void) {
        let requestModel = CreateRequest(baseUrl: baseUrl, model: model)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func delete(commentId: Int, completionHandler: @escaping (AFDataResponse<ResultResponse>) -> Void) {
        let requestModel = DeleteRequest(baseUrl: baseUrl, commentId: commentId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func approve(commentId: Int, completionHandler: @escaping (AFDataResponse<ResultResponse>) -> Void) {
        let requestModel = ApproveRequest(baseUrl: baseUrl, commentId: commentId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Reviews {
    struct ListRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        var path: String = "reviews"
        
        let page: Int
        
        var parameters: Parameters? {
            return [
                "page": page
            ]
        }
    }
    
    struct CreateRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        var path: String = "reviews"
        
        let model: CreateReviewModel
        
        var parameters: Parameters? {
            return [
                "id_user": model.userId,
                "text": model.text,
            ]
        }
    }
    
    struct DeleteRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        var path: String = "reviews/delete"
        
        let commentId: Int
        
        var parameters: Parameters? {
            return [
                "id_comment": commentId,
            ]
        }
    }
    
    struct ApproveRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        var path: String = "reviews/approve"
        
        let commentId: Int
        
        var parameters: Parameters? {
            return [
                "id_comment": commentId,
            ]
        }
    }
}
