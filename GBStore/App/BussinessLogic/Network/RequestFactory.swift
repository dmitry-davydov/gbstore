//
//  RequestFactory.swift
//  GBStore
//
//  Created by Дима Давыдов on 24.06.2021.
//

import Foundation
import Alamofire


class RequestFactory {
    
    func makeErrorParser() -> AbstractErrorParser {
        return (UIApplication.shared.delegate as! AppDelegate).container.resolve(AbstractErrorParser.self)!
    }
    
    lazy var commonSession: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let manager = Session(configuration: configuration)
        return manager
    }()
    
    let sessionQueue = DispatchQueue.global(qos: .utility)
    
    func makeUserRequestFatory() -> UserRequestFactory {
        return (UIApplication.shared.delegate as! AppDelegate).container.resolve(
            UserRequestFactory.self,
            arguments: makeErrorParser(), commonSession, sessionQueue
        )!
    }
    
    func makeProductRequestFactory() -> ProductRequestFactory {
        return (UIApplication.shared.delegate as! AppDelegate).container.resolve(
            ProductRequestFactory.self,
            arguments: makeErrorParser(), commonSession, sessionQueue
        )!
    }
}
