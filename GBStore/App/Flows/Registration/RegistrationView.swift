//
//  RegistrationView.swift
//  GBStore
//
//  Created by Дима Давыдов on 14.07.2021.
//

import UIKit
import PinLayout

class RegistrationView: UIView {
    // MARK: - UI Views
    
    private let scrollView = UIScrollView()
    private let titleLabel = UILabel()
    
    private let usernameTextField = CustomTextField(height: FormElementStyle.formItemHeight)
    private let passwordTextField = CustomTextField(height: FormElementStyle.formItemHeight)
    private let emailTextField = CustomTextField(height: FormElementStyle.formItemHeight)
    
    private let maleLabel = UILabel()
    private let genderSwitcher = UISwitch()
    private let femaleLabel = UILabel()
    
    private let creaditcardTextField = CustomTextField(height: FormElementStyle.formItemHeight)
    private let bioTextField = CustomTextField(height: FormElementStyle.formItemHeight)
    private let submitButton = CustomSubmitButton(height: FormElementStyle.formItemHeight, cornerRadius: FormElementStyle.cornerRadius)
    
    private let formContainer = UIView()
    private let moveToLoginButton = UIButton()
    
    private var submitButtonEnabled = true
    
    // MARK: - presenter
    var presenter: RegistrationPresenter?
    
    init(presenter: RegistrationPresenter) {
        super.init(frame: .zero)
        self.presenter = presenter
        
        addSubview(scrollView)
        scrollView.addSubview(formContainer)
        
        backgroundColor = .white
        
        //MARK: - title label configuration
        titleLabel.text = "Registration"
        titleLabel.font = .boldSystemFont(ofSize: Style.headerLabelFontSize)
        titleLabel.textColor = .black
        titleLabel.sizeToFit()
        formContainer.addSubview(titleLabel)
        
        //MARK: - username text field configuration
        usernameTextField.placeholder = "Username"
        formContainer.addSubview(usernameTextField)
        
        //MARK: - password text field configuration
        passwordTextField.placeholder = "Password"
        formContainer.addSubview(passwordTextField)
        
        //MARK: - email text field configuration
        emailTextField.placeholder = "Email"
        emailTextField.keyboardType = .emailAddress
        formContainer.addSubview(emailTextField)
        
        //MARK: - creadit card text field configuration
        creaditcardTextField.placeholder = "Credit card"
        formContainer.addSubview(creaditcardTextField)
        
        //MARK: - gender configuration
        maleLabel.text = "Male"
        maleLabel.sizeToFit()
        maleLabel.pin.height(FormElementStyle.formItemHeight)
        femaleLabel.text = "Female"
        femaleLabel.sizeToFit()
        femaleLabel.pin.height(FormElementStyle.formItemHeight)
        
        formContainer.addSubview(femaleLabel)
        formContainer.addSubview(genderSwitcher)
        formContainer.addSubview(maleLabel)
        
        //MARK: - bio text field configuration
        bioTextField.placeholder = "Bio"
        formContainer.addSubview(bioTextField)
        
        //MARK: - submit button configuration
        submitButton.setTitle("Submit", for: .normal)
        submitButton.addTarget(self, action: #selector(submittButtonTapped), for: .touchUpInside)
        
        formContainer.addSubview(submitButton)
        
        moveToLoginButton.setTitle("Login", for: .normal)
        moveToLoginButton.setTitleColor(.blue, for: .normal)
        moveToLoginButton.pin.height(FormElementStyle.formItemHeight)
        formContainer.addSubview(moveToLoginButton)
        
        // MARK: - Button targets configuration
        moveToLoginButton.addTarget(self, action: #selector(moveToLogin), for: .touchUpInside)
    }
    
    func viewWillChangeContentInsets(bottom: CGFloat) {
        scrollView.contentInset.bottom = bottom
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        scrollView.pin.all(pin.safeArea)
        formContainer.pin.width(100%).top(pin.safeArea).hCenter().pinEdges()
        titleLabel.pin.hCenter().top()
        
        usernameTextField.pin
            .below(of: titleLabel)
            .horizontally()
            .margin(FormElementStyle.leftMargin)
            .marginTop(FormElementStyle.topMargin)
            .marginBottom(FormElementStyle.bottomMargin)
        
        passwordTextField.pin
            .below(of: usernameTextField)
            .horizontally()
            .margin(FormElementStyle.leftMargin)
            .marginTop(FormElementStyle.topMargin)
            .marginBottom(FormElementStyle.bottomMargin)
        
        emailTextField.pin
            .below(of: passwordTextField)
            .horizontally()
            .margin(FormElementStyle.leftMargin)
            .marginTop(FormElementStyle.topMargin)
            .marginBottom(FormElementStyle.bottomMargin)
        
        creaditcardTextField.pin
            .below(of: emailTextField)
            .horizontally()
            .margin(FormElementStyle.leftMargin)
            .marginTop(FormElementStyle.topMargin)
            .marginBottom(FormElementStyle.bottomMargin)
        
        femaleLabel.pin
            .below(of: creaditcardTextField, aligned: .left)
            .marginTop(FormElementStyle.topMargin)
        
        genderSwitcher.pin
            .after(of: femaleLabel, aligned: .top)
            .marginTop(FormElementStyle.topMargin / 2)
            .marginLeft(FormElementStyle.leftMargin)
        
        maleLabel.pin
            .after(of: femaleLabel, aligned: .top)
            .marginLeft(FormElementStyle.leftMargin + genderSwitcher.frame.width + FormElementStyle.leftMargin)
        
        bioTextField.pin
            .below(of: femaleLabel)
            .horizontally()
            .margin(FormElementStyle.leftMargin)
            .marginTop(FormElementStyle.topMargin)
            .marginBottom(FormElementStyle.bottomMargin)
        
        submitButton.pin
            .below(of: bioTextField)
            .horizontally()
            .margin(FormElementStyle.leftMargin)
            .marginTop(FormElementStyle.topMargin)
        
        moveToLoginButton.pin
            .below(of: submitButton)
            .width(100%)
            .marginTop(FormElementStyle.leftMargin)
        
        formContainer.pin.wrapContent(.vertically)
        scrollView.contentSize = frame.size
    }
    
    //MARK: - submit button touch up inside target
    @objc
    func submittButtonTapped(_ sender: UIButton) {
        if !submitButtonEnabled {
            return
        }
        
        let createUserRequest = CreateUserRequest(
            username: usernameTextField.text ?? "",
            password: passwordTextField.text ?? "",
            email: emailTextField.text ?? "",
            gender: genderSwitcher.isOn ? .male : .female,
            creditCard: creaditcardTextField.text ?? "",
            bio: bioTextField.text ?? ""
        )
        
        presenter?.viewDidSubmit(createUserRequest)
    }
    
    @objc
    func moveToLogin(_ sender: UIButton) {
        presenter?.viewDidMoveToRegistration()
    }
}

//MARK: - Implementation of RegistrationViewInput for RegistrationView
extension RegistrationView: RegistrationViewInput {
    
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
