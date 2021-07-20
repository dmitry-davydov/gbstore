//
//  LoginView.swift
//  GBStore
//
//  Created by Дима Давыдов on 11.07.2021.
//

import UIKit
import PinLayout

// MARK: - LoginView class
class LoginView: UIView {
    
    // MARK:- UI views
    private let formContainer = UIView()
    private let titleLabel = UILabel()
    private let usernameField = UITextField()
    private let passwordField = UITextField()
    private let submitButton = UIButton()
    private let moveToRegistrationButton = UIButton()
    
    // MARK: - presenter
    var presenter: LoginPresenter?
    
    private var submitButtonEnabled = true
    
    // MARK: - init function
    init(presenter: LoginPresenter) {
        super.init(frame: .zero)
        
        self.presenter = presenter
        
        addSubview(formContainer)
        
        let textFieldHeight: CGFloat = 40
        let textFieldCornerRadius: CGFloat = 4
        let textFieldPlaceholderPadding: CGFloat = 12
        
        backgroundColor = .white
        
        // MARK: - Title label configuration
        titleLabel.text = "Login"
        titleLabel.font = .boldSystemFont(ofSize: 28)
        titleLabel.textColor = .black
        titleLabel.sizeToFit()
        formContainer.addSubview(titleLabel)
        
        // MARK: - Username text field configuration
        usernameField.placeholder = "Username"
        usernameField.layer.borderColor = UIColor.gray.cgColor
        usernameField.layer.borderWidth = 1
        usernameField.layer.cornerRadius = textFieldCornerRadius
        usernameField.pin.height(textFieldHeight)
        usernameField.leftView = UIView.init(frame: CGRect(x: 0, y: 0, width: textFieldPlaceholderPadding, height: textFieldHeight))
        usernameField.leftViewMode = .always
        formContainer.addSubview(usernameField)
        
        // MARK: - Password text field configuration
        passwordField.placeholder = "Password"
        passwordField.isSecureTextEntry = true
        passwordField.layer.borderColor = UIColor.gray.cgColor
        passwordField.layer.borderWidth = 1
        passwordField.layer.cornerRadius = textFieldCornerRadius
        passwordField.pin.height(textFieldHeight)
        passwordField.leftView = UIView.init(frame: CGRect(x: 0, y: 0, width: textFieldPlaceholderPadding, height: textFieldHeight))
        passwordField.leftViewMode = .always
        formContainer.addSubview(passwordField)
        
        // MARK: - Submit button configuration
        submitButton.setTitle("Submit", for: .normal)
        submitButton.backgroundColor = .gray
        submitButton.pin.height(textFieldHeight)
        submitButton.layer.cornerRadius = textFieldCornerRadius
        formContainer.addSubview(submitButton)
        
        // MARK: - Move to register button configuration
        moveToRegistrationButton.setTitle("Register", for: .normal)
        moveToRegistrationButton.setTitleColor(.blue, for: .normal)
        moveToRegistrationButton.pin.height(textFieldHeight)
        formContainer.addSubview(moveToRegistrationButton)
        
        // MARK: - Button targets
        moveToRegistrationButton.addTarget(self, action: #selector(moveToRegistration), for: .touchUpInside)
        submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let leftRightMargin: CGFloat = 16
        let topMargin: CGFloat = 12
        
        
        formContainer.pin.width(100%)
        titleLabel.pin.hCenter().top(pin.safeArea)
        
        usernameField.pin
            .below(of: titleLabel)
            .horizontally()
            .margin(leftRightMargin)
            .marginBottom(0)
        
        passwordField.pin
            .below(of: usernameField)
            .horizontally()
            .margin(leftRightMargin)
            .marginTop(topMargin)
        
        submitButton.pin
            .below(of: passwordField)
            .horizontally()
            .margin(leftRightMargin)
            .marginTop(topMargin)
        
        moveToRegistrationButton.pin
            .below(of: submitButton)
            .width(100%)
            .marginTop(leftRightMargin)
        
        formContainer.pin.wrapContent(.vertically)
        formContainer.pin.center().marginTop(-formContainer.frame.height/2)
    }
    
    // MARK: - Submit button touch up inside target
    @objc
    func submitTapped(_ sender: UIButton) {
        
        if !submitButtonEnabled {
            return
        }
        
        presenter?.viewDidSubmit(
            username: usernameField.text ?? "",
            password: passwordField.text ?? ""
        )
    }
    
    @objc
    func moveToRegistration(_ sender: UIButton) {
        presenter?.viewDidMoveToRegistration()
    }
}

// MARK: - Implementation of LoginViewInput for LoginView
extension LoginView: LoginViewInput {
    
    func enableSubmitButton() {
        submitButton.isEnabled = true
        submitButtonEnabled = true
        submitButton.backgroundColor = .gray
    }
    
    func disableSubmitButton() {
        submitButton.isEnabled = false
        submitButtonEnabled = false
        submitButton.backgroundColor = .lightGray
    }
}
