//
//  LoginViewController.swift
//  GBStore
//
//  Created by Дима Давыдов on 11.07.2021.
//

import UIKit

class LoginViewController: UIViewController {
    private var loginView: LoginView {
        guard let loginView = ( view as? LoginView) else {
            fatalError("View is not instance of LoginView")
        }
        
        return loginView
    }
    
    override func loadView() {
        let presenter = LoginPresenter()
        presenter.viewInput = self
        view = LoginView(presenter: presenter)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc
    func adjustForKeyboard(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        let keyboardViewEndFrame = view.convert(keyboardSize, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            loginView.viewWillChangeContentInsets(bottom: 0)
            return
        }
        
        loginView.viewWillChangeContentInsets(bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom)
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
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
