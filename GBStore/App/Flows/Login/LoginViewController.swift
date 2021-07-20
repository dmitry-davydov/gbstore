//
//  LoginViewController.swift
//  GBStore
//
//  Created by Дима Давыдов on 11.07.2021.
//

import UIKit

class LoginViewController: UIViewController {
    private var loginView: LoginView {
        return view as! LoginView
    }
    
    override func loadView() {
        let presenter = LoginPresenter()
        presenter.viewInput = self
        view = LoginView(presenter: presenter)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

extension LoginViewController: LoginViewInput {
    func enableSubmitButton() {
        loginView.enableSubmitButton()
    }
    
    func disableSubmitButton() {
        loginView.disableSubmitButton()
    }
}
