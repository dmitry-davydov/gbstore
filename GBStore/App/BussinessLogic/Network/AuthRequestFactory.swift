//
//  AuthRequestFactory.swift
//  GBStore
//
//  Created by Дима Давыдов on 24.06.2021.
//

import Foundation
import Alamofire

protocol AuthRequestFactory{
    func login(userName: String, password: String, completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void)
}
