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
    func logout(completionHandler: @escaping (AFDataResponse<LogoutResponse>) -> Void)
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
    
    func logout(completionHandler: @escaping (AFDataResponse<LogoutResponse>) -> Void) {
        let requestModel = Logout(baseUrl: baseUrl)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension User {
    struct Login: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "login.json"
        
        let model: LoginRequest
        
        var parameters: Parameters? {
            return [
                "username": model.userName,
                "password": model.password
            ]
        }
    }
    
    struct Logout: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "logout.json"
        
        var parameters: Parameters? {
            return nil
        }
    }
    
    struct CreateUser: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "registerUser.json"
        
        let model: CreateUserRequest
        
        var parameters: Parameters? {
            return [
                "username" : model.username,
                "password" : model.password,
                "email" : model.email,
                "gender": model.gender.rawValue,
                "credit_card" : model.creditCard,
                "bio" : model.bio,
            ]
        }
    }
    
    struct UpdateUser: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "changeUserData.json"
        
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
