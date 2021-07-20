//
//  RegistrationViewController.swift
//  GBStore
//
//  Created by Дима Давыдов on 14.07.2021.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    private var registrationView: RegistrationView {
        return view as! RegistrationView
    }
    
    override func loadView() {
        let presenter = RegistrationPresenter()
        presenter.viewInput = self
        view = RegistrationView(presenter: presenter)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

//MARK: - Implementation of RegistrationViewInput for RegistrationViewController
extension RegistrationViewController: RegistrationViewInput {
    
    func enableSubmitButton() {
        registrationView.enableSubmitButton()
    }
    
    func disableSubmitButton() {
        registrationView.disableSubmitButton()
    }
}
