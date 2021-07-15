//
//  UserProfileView.swift
//  GBStore
//
//  Created by Дима Давыдов on 14.07.2021.
//

import UIKit
import PinLayout

class UserProfileView: UIView {
    
    // MARK: - UI Views
    
    private let titleLabel = UILabel()
    
    private let usernameTextField = UITextField()
    private let passwordTextField = UITextField()
    private let emailTextField = UITextField()
    
    private let maleLabel = UILabel()
    private let genderSwitcher = UISwitch()
    private let femaleLabel = UILabel()
    
    private let creaditcardTextField = UITextField()
    private let bioTextField = UITextField()
    private let submitButton = UIButton()
    
    private let formContainer = UIView()
    
    private var submitButtonEnabled = true
    
    // MARK: - presenter
    var presenter: UserProfilePresenter?
    var userModel: UserResponse?
    
    init(presenter: UserProfilePresenter, userModel: UserResponse?) {
        super.init(frame: .zero)
        self.presenter = presenter
        self.userModel = userModel
        
        let textFieldHeight: CGFloat = 40
        let textFieldCornerRadius: CGFloat = 4
        let textFieldPlaceholderPadding: CGFloat = 12
        
        addSubview(formContainer)
        
        backgroundColor = .white
        
        //MARK: - title label configuration
        titleLabel.text = "Edit Profile"
        titleLabel.font = .boldSystemFont(ofSize: 28)
        titleLabel.textColor = .black
        titleLabel.sizeToFit()
        formContainer.addSubview(titleLabel)
        
        //MARK: - username text field configuration
        usernameTextField.placeholder = "Username"
        usernameTextField.layer.borderColor = UIColor.gray.cgColor
        usernameTextField.layer.borderWidth = 1
        usernameTextField.layer.cornerRadius = textFieldCornerRadius
        usernameTextField.pin.height(textFieldHeight)
        usernameTextField.leftView = UIView.init(frame: CGRect(x: 0, y: 0, width: textFieldPlaceholderPadding, height: textFieldHeight))
        usernameTextField.leftViewMode = .always
        usernameTextField.text = userModel?.lastname
        formContainer.addSubview(usernameTextField)
        
        //MARK: - password text field configuration
        passwordTextField.placeholder = "Password"
        passwordTextField.layer.borderColor = UIColor.gray.cgColor
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.cornerRadius = textFieldCornerRadius
        passwordTextField.pin.height(textFieldHeight)
        passwordTextField.leftView = UIView.init(frame: CGRect(x: 0, y: 0, width: textFieldPlaceholderPadding, height: textFieldHeight))
        passwordTextField.leftViewMode = .always
        formContainer.addSubview(passwordTextField)
        
        //MARK: - email text field configuration
        emailTextField.placeholder = "Email"
        emailTextField.layer.borderColor = UIColor.gray.cgColor
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.cornerRadius = textFieldCornerRadius
        emailTextField.pin.height(textFieldHeight)
        emailTextField.leftView = UIView.init(frame: CGRect(x: 0, y: 0, width: textFieldPlaceholderPadding, height: textFieldHeight))
        emailTextField.leftViewMode = .always
        emailTextField.keyboardType = .emailAddress
        emailTextField.text = userModel?.login
        formContainer.addSubview(emailTextField)
        
        //MARK: - creadit card text field configuration
        creaditcardTextField.placeholder = "Credit card"
        creaditcardTextField.layer.borderColor = UIColor.gray.cgColor
        creaditcardTextField.layer.borderWidth = 1
        creaditcardTextField.layer.cornerRadius = textFieldCornerRadius
        creaditcardTextField.pin.height(textFieldHeight)
        creaditcardTextField.leftView = UIView.init(frame: CGRect(x: 0, y: 0, width: textFieldPlaceholderPadding, height: textFieldHeight))
        creaditcardTextField.leftViewMode = .always
        formContainer.addSubview(creaditcardTextField)
        
        //MARK: - gender configuration
        maleLabel.text = "Male"
        maleLabel.sizeToFit()
        maleLabel.pin.height(textFieldHeight)
        femaleLabel.text = "Female"
        femaleLabel.sizeToFit()
        femaleLabel.pin.height(textFieldHeight)
        
        formContainer.addSubview(femaleLabel)
        formContainer.addSubview(genderSwitcher)
        formContainer.addSubview(maleLabel)
        
        //MARK: - bio text field configuration
        bioTextField.placeholder = "Bio"
        bioTextField.layer.borderColor = UIColor.gray.cgColor
        bioTextField.layer.borderWidth = 1
        bioTextField.layer.cornerRadius = textFieldCornerRadius
        bioTextField.pin.height(textFieldHeight)
        bioTextField.leftView = UIView.init(frame: CGRect(x: 0, y: 0, width: textFieldPlaceholderPadding, height: textFieldHeight))
        bioTextField.leftViewMode = .always
        formContainer.addSubview(bioTextField)
        
        //MARK: - submit button configuration
        submitButton.setTitle("Submit", for: .normal)
        submitButton.backgroundColor = .gray
        submitButton.pin.height(textFieldHeight)
        submitButton.layer.cornerRadius = textFieldCornerRadius
        
        // MARK: - Button targets configuration
        submitButton.addTarget(self, action: #selector(submittButtonTapped), for: .touchUpInside)
        
        formContainer.addSubview(submitButton)
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
        
        usernameTextField.pin
            .below(of: titleLabel)
            .horizontally()
            .margin(leftRightMargin)
            .marginTop(topMargin)
            .marginBottom(0)
        
        passwordTextField.pin
            .below(of: usernameTextField)
            .horizontally()
            .margin(leftRightMargin)
            .marginTop(topMargin)
            .marginBottom(0)
        
        emailTextField.pin
            .below(of: passwordTextField)
            .horizontally()
            .margin(leftRightMargin)
            .marginTop(topMargin)
            .marginBottom(0)
        
        creaditcardTextField.pin
            .below(of: emailTextField)
            .horizontally()
            .margin(leftRightMargin)
            .marginTop(topMargin)
            .marginBottom(0)
        
        femaleLabel.pin
            .below(of: creaditcardTextField, aligned: .left)
            .marginTop(topMargin)
        
        genderSwitcher.pin
            .after(of: femaleLabel, aligned: .top)
            .marginTop(topMargin / 2)
            .marginLeft(leftRightMargin)
        
        maleLabel.pin
            .after(of: femaleLabel, aligned: .top)
            .marginLeft(leftRightMargin + genderSwitcher.frame.width + leftRightMargin)
        
        bioTextField.pin
            .below(of: femaleLabel)
            .horizontally()
            .margin(leftRightMargin)
            .marginTop(topMargin)
            .marginBottom(0)
        
        submitButton.pin
            .below(of: bioTextField)
            .horizontally()
            .margin(leftRightMargin)
            .marginTop(topMargin)
        
        formContainer.pin.wrapContent(.vertically)
        formContainer.pin.center().marginTop(-formContainer.frame.height/2)
    }
    
    //MARK: - submit button touch up inside target
    @objc
    func submittButtonTapped(_ sender: UIButton) {
        if !submitButtonEnabled {
            return
        }
        
        let updateUserRequest = UpdateUserRequest(
            id: 1,
            username: usernameTextField.text ?? "",
            password: passwordTextField.text ?? "",
            email: emailTextField.text ?? "",
            gender: genderSwitcher.isOn ? .female : .male,
            creditCard: creaditcardTextField.text ?? "",
            bio: bioTextField.text ?? ""
        )
        
        presenter?.viewDidSubmit(updateUserRequest)
    }
}

extension UserProfileView: UserProfileViewInput {
    
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
