//
//  UserProfilePresenter.swift
//  GBStore
//
//  Created by Дима Давыдов on 14.07.2021.
//

import UIKit

// MARK: - Presenter protocols
protocol UserProfileViewInput {
    func enableSubmitButton()
    func disableSubmitButton()
}

protocol UserProfileViewOutput {
    func viewDidSubmit(_ model: UpdateUserRequest)
}

// MARK: - Presenter class
class UserProfilePresenter {
    weak var viewInput: (UIViewController & UserProfileViewInput)?
    lazy var userRequestFactory: UserRequestFactory = {
        let requestFactory = RequestFactory()
        
        return requestFactory.makeUserRequestFatory()
    }()
}

//MARK: - Implementation UserProfileViewOutput for UserProfilePresenter
extension UserProfilePresenter: UserProfileViewOutput {
    func viewDidSubmit(_ model: UpdateUserRequest) {
        
        viewInput?.disableSubmitButton()
        
        userRequestFactory.update(model: model) { [weak self] response in
        
            DispatchQueue.main.async {
                self?.viewInput?.enableSubmitButton()
            }
            
            switch response.result {
            case .success(_):
                // ничего не делаем
                print("user update success")
                break
            case .failure(let err):
                print(err.errorDescription)
            }
        }
    }
}
