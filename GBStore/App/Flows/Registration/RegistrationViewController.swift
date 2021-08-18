//
//  RegistrationViewController.swift
//  GBStore
//
//  Created by Дима Давыдов on 14.07.2021.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    private var registrationView: RegistrationView {
        guard let registrationView = (view as? RegistrationView) else {
            fatalError("View is not instance of RegistrationView")
        }
        
        return registrationView
    }
    
    // MARK: - View Controller lifecycle
    
    override func loadView() {
        let presenter = RegistrationPresenter()
        presenter.viewInput = self
        view = RegistrationView(presenter: presenter)
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
    
    // MARK: - Keyboard notification handler
    @objc
    func adjustForKeyboard(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        let keyboardViewEndFrame = view.convert(keyboardSize, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            registrationView.viewWillChangeContentInsets(bottom: 0)
        } else {
            registrationView.viewWillChangeContentInsets(bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom)
        }
    }
    
    // MARK: - Tap gesture handler
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
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
