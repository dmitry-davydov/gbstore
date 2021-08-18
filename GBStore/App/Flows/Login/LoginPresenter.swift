//
//  LoginPresenter.swift
//  GBStore
//
//  Created by Дима Давыдов on 12.07.2021.
//

import UIKit

// MARK: - Presenter protocols
protocol LoginViewInput {
    func enableSubmitButton()
    func disableSubmitButton()
}

protocol LoginViewOutput {
    func viewDidSubmit(username: String, password: String)
    func viewDidMoveToRegistration()
    func viewDidSuccessLogin(model: LoginResponse)
}

// MARK: - Presenter class
class LoginPresenter {
    weak var viewInput: (UIViewController & LoginViewInput)?
    
    lazy var userRequestFactory: UserRequestFactory = {
        let requestFactory = RequestFactory()
        
        return requestFactory.makeUserRequestFatory()
    }()
}


// MARK: - LoginViewOutput implementation for LoginPresenter
extension LoginPresenter: LoginViewOutput {
    
    func viewDidSubmit(username: String, password: String) {
        viewInput?.disableSubmitButton()
        
        let requestModel = LoginRequest(userName: username, password: password)
        userRequestFactory.login(model: requestModel) { [weak self] response in
            
            print("Login request with data: \(requestModel)")
            
            DispatchQueue.main.async {
                self?.viewInput?.enableSubmitButton()
            }
            
            switch response.result {
            case .success(let user):
                print("Login response with data: \(user)")
                if user.isSuccess() {
                    DispatchQueue.main.async {
                        self?.viewDidSuccessLogin(model: user)
                    }
                }
                break
            case .failure(let err):
                print("Login response with error \(err.localizedDescription)")
            }
        }
    }
    
    func viewDidSuccessLogin(model: LoginResponse) {
        
        UserSession.shared.setUser(loginResponse: model)
        
        UIApplication.shared.windows[0].rootViewController = TabBarViewController()
        UIApplication.shared.windows[0].makeKeyAndVisible()
    }
    
    func viewDidMoveToRegistration() {
        let registrationViewController = RegistrationViewController()
        
        viewInput?.navigationController?.pushViewController(registrationViewController, animated: true)
    }
}
