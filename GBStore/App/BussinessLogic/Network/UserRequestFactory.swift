//
//  UserRequestFactory.swift
//  GBStore
//
//  Created by Дима Давыдов on 24.06.2021.
//

import Foundation
import Alamofire

protocol UserRequestFactory {
    func login(model: LoginRequest, completionHandler: @escaping (AFDataResponse<LoginResponse>) -> Void)
    func logout(userId: Int, completionHandler: @escaping (AFDataResponse<LogoutResponse>) -> Void)
    func create(model: CreateUserRequest, completionHandler: @escaping (AFDataResponse<CreateUserResponse>) -> Void)
    func update(model: UpdateUserRequest, completionHandler: @escaping (AFDataResponse<UpdateUserResponse>) -> Void)
}

class User: AbstractRequestFactory {
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

extension User: UserRequestFactory {
    func create(model: CreateUserRequest, completionHandler: @escaping (AFDataResponse<CreateUserResponse>) -> Void) {
        let requestModel = CreateUser(baseUrl: baseUrl, model: model)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func update(model: UpdateUserRequest, completionHandler: @escaping (AFDataResponse<UpdateUserResponse>) -> Void) {
        let requestModel = UpdateUser(baseUrl: baseUrl, model: model)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func login(model: LoginRequest, completionHandler: @escaping (AFDataResponse<LoginResponse>) -> Void) {
        let requestModel = Login(baseUrl: baseUrl, model: model)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func logout(userId: Int, completionHandler: @escaping (AFDataResponse<LogoutResponse>) -> Void) {
        let requestModel = Logout(baseUrl: baseUrl, userId: userId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension User {
    struct Login: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "user/auth"
        
        let model: LoginRequest
        
        var parameters: Parameters? {
            return [
                "username": model.userName,
                "password": model.password,
                "cookies": "123"
            ]
        }
    }
    
    struct Logout: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "user/logout"
        
        let userId: Int
        
        var parameters: Parameters? {
            return [
                "id_user": userId
            ]
        }
    }
    
    struct CreateUser: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "user/create"
        
        let model: CreateUserRequest
        
        var parameters: Parameters? {
            return [
                "username" : model.username,
                "password" : model.password,
                "email" : model.email,
                "gender": model.gender.rawValue,
                "credit_card" : model.creditCard,
                "bio" : model.bio,
                "id_user": 123
            ]
        }
    }
    
    struct UpdateUser: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "user/update"
        
        let model: UpdateUserRequest
        
        var parameters: Parameters? {
            return [
                "id_user": model.id,
                "username" : model.username,
                "password" : model.password,
                "email" : model.email,
                "gender": model.gender.rawValue,
                "credit_card" : model.creditCard,
                "bio" : model.bio,
            ]
        }
    }
}
