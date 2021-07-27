//
//  RequestRouter.swift
//  GBStore
//
//  Created by Дима Давыдов on 24.06.2021.
//

import Foundation
import Alamofire

enum RequestRouterEncoding {
    case url, json
}

enum RequestRouterError: Error {
    case invalidUrl
}

protocol RequestRouter: URLRequestConvertible {
    var baseUrl: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var encoding: RequestRouterEncoding { get }
}

extension RequestRouter {
    
    var encoding: RequestRouterEncoding {
        return .url
    }
    
    func asURLRequest() throws -> URLRequest {
        
        guard let baseUrl = URL.init(string: baseUrl) else {
            throw RequestRouterError.invalidUrl
        }
        
        let fullUrl = baseUrl.appendingPathComponent(path)
        
        var urlRequest = URLRequest(url: fullUrl)
        urlRequest.httpMethod = method.rawValue
        
        switch self.encoding {
        case .url:
            return try URLEncoding.default.encode(urlRequest, with: parameters)
        case .json:
            return try JSONEncoding.default.encode(urlRequest, with: parameters)
        }
    }
}
