//
//  RegistrationPresenter.swift
//  GBStore
//
//  Created by Дима Давыдов on 14.07.2021.
//

import UIKit

// MARK: - Presenter protocols
protocol RegistrationViewInput {
    func enableSubmitButton()
    func disableSubmitButton()
}

protocol RegistrationViewOutput {
    func viewDidSubmit(_ model: CreateUserRequest)
    func viewDidMoveToRegistration()
}

// MARK: - Presenter class
class RegistrationPresenter {
    weak var viewInput: (UIViewController & RegistrationViewInput)?
    lazy var userRequestFactory: UserRequestFactory = {
        let requestFactory = RequestFactory()
        
        return requestFactory.makeUserRequestFatory()
    }()
}

// MARK: - Implementation RegistrationViewOutput for RegistrationPresenter
extension RegistrationPresenter: RegistrationViewOutput {
    
    func viewDidMoveToRegistration() {
        viewInput?.navigationController?.popViewController(animated: true)
    }
    
    func viewDidSubmit(_ model: CreateUserRequest) {
        
        viewInput?.disableSubmitButton()
        
        userRequestFactory.create(model: model) { [weak self] response in
            
            DispatchQueue.main.async {
                self?.viewInput?.enableSubmitButton()
            }
            
            switch response.result {
            case .success(_):
                DispatchQueue.main.async {
                    self?.viewDidMoveToRegistration()
                }
                break
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
