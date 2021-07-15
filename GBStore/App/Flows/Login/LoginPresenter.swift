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
        
        userRequestFactory.login(model: LoginRequest(userName: username, password: password)) { [weak self] response in
            
            DispatchQueue.main.async {
                self?.viewInput?.enableSubmitButton()
            }
            
            switch response.result {
            case .success(let user):
                DispatchQueue.main.async {
                    self?.viewDidSuccessLogin(model: user)
                }
                
                break
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func viewDidSuccessLogin(model: LoginResponse) {
        let userProfileViewController = UserProfileViewController()
        userProfileViewController.userModel = model.user
        viewInput?.navigationController?.pushViewController(userProfileViewController, animated: true)
    }
    
    func viewDidMoveToRegistration() {
        let registrationViewController = RegistrationViewController()
        
        viewInput?.navigationController?.pushViewController(registrationViewController, animated: true)
    }
}
