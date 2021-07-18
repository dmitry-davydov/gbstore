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
    private let usernameField = CustomTextField(height: FormElementStyle.formItemHeight)
    private let passwordField = CustomTextField(height: FormElementStyle.formItemHeight)
    private let submitButton = CustomSubmitButton(height: FormElementStyle.formItemHeight, cornerRadius: FormElementStyle.cornerRadius)
    private let moveToRegistrationButton = UIButton()
    
    // MARK: - presenter
    var presenter: LoginPresenter?
    
    private var submitButtonEnabled = true
    
    // MARK: - init function
    init(presenter: LoginPresenter) {
        super.init(frame: .zero)
        
        self.presenter = presenter
        
        addSubview(formContainer)
        
        backgroundColor = .white
        
        // MARK: - Title label configuration
        titleLabel.text = "Login"
        titleLabel.font = .boldSystemFont(ofSize: Style.headerLabelFontSize)
        titleLabel.textColor = .black
        titleLabel.sizeToFit()
        formContainer.addSubview(titleLabel)
        
        // MARK: - Username text field configuration
        usernameField.placeholder = "Username"
        formContainer.addSubview(usernameField)
        
        // MARK: - Password text field configuration
        passwordField.placeholder = "Password"
        passwordField.isSecureTextEntry = true
        formContainer.addSubview(passwordField)
        
        // MARK: - Submit button configuration
        submitButton.setTitle("Submit", for: .normal)
        formContainer.addSubview(submitButton)
        
        // MARK: - Move to register button configuration
        moveToRegistrationButton.setTitle("Register", for: .normal)
        moveToRegistrationButton.setTitleColor(.blue, for: .normal)
        moveToRegistrationButton.pin.height(FormElementStyle.formItemHeight)
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
        
        formContainer.pin.width(100%)
        titleLabel.pin.hCenter().top(pin.safeArea)
        
        usernameField.pin
            .below(of: titleLabel)
            .horizontally()
            .margin(FormElementStyle.leftMargin)
            .marginBottom(FormElementStyle.bottomMargin)
        
        passwordField.pin
            .below(of: usernameField)
            .horizontally()
            .margin(FormElementStyle.leftMargin)
            .marginTop(FormElementStyle.topMargin)
        
        submitButton.pin
            .below(of: passwordField)
            .horizontally()
            .margin(FormElementStyle.leftMargin)
            .marginTop(FormElementStyle.topMargin)
        
        moveToRegistrationButton.pin
            .below(of: submitButton)
            .width(100%)
            .marginTop(FormElementStyle.leftMargin)
        
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
