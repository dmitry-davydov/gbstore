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
    
    private let scrollView = UIScrollView()
    private let titleLabel = UILabel()
    
    private let usernameTextField = CustomTextField(height: FormElementStyle.formItemHeight)
    private let passwordTextField = CustomTextField(height: FormElementStyle.formItemHeight)
    private let emailTextField = CustomTextField(height: FormElementStyle.formItemHeight)
    
    private let genderSegmentedControl = UISegmentedControl(items: ["Female", "Male"])
    
    private let creaditcardTextField = CustomTextField(height: FormElementStyle.formItemHeight)
    private let bioTextField = CustomTextField(height: FormElementStyle.formItemHeight)
    private let submitButton = CustomSubmitButton(height: FormElementStyle.formItemHeight, cornerRadius: FormElementStyle.cornerRadius)
    
    private let formContainer = UIView()
    
    private var submitButtonEnabled = true
    
    // MARK: - presenter
    var presenter: UserProfilePresenter?
    var userModel: UserResponse?
    
    init(presenter: UserProfilePresenter, userModel: UserResponse?) {
        super.init(frame: .zero)
        self.presenter = presenter
        self.userModel = userModel
        
        addSubview(scrollView)
        scrollView.addSubview(formContainer)
        backgroundColor = .white
        
        //MARK: - title label configuration
        titleLabel.text = "Edit Profile"
        titleLabel.font = .boldSystemFont(ofSize: Style.headerLabelFontSize)
        titleLabel.textColor = .black
        titleLabel.sizeToFit()
        formContainer.addSubview(titleLabel)
        
        //MARK: - username text field configuration
        usernameTextField.placeholder = "Username"
        usernameTextField.text = userModel?.lastname
        formContainer.addSubview(usernameTextField)
        
        //MARK: - password text field configuration
        passwordTextField.placeholder = "Password"
        formContainer.addSubview(passwordTextField)
        
        //MARK: - email text field configuration
        emailTextField.placeholder = "Email"
        emailTextField.keyboardType = .emailAddress
        emailTextField.text = userModel?.login
        formContainer.addSubview(emailTextField)
        
        //MARK: - creadit card text field configuration
        creaditcardTextField.placeholder = "Credit card"
        formContainer.addSubview(creaditcardTextField)
        
        //MARK: - gender configuration
        genderSegmentedControl.selectedSegmentIndex = 0
        formContainer.addSubview(genderSegmentedControl)
        
        //MARK: - bio text field configuration
        bioTextField.placeholder = "Bio"
        formContainer.addSubview(bioTextField)
        
        //MARK: - submit button configuration
        submitButton.setTitle("Submit", for: .normal)
        
        // MARK: - Button targets configuration
        submitButton.addTarget(self, action: #selector(submittButtonTapped), for: .touchUpInside)
        
        formContainer.addSubview(submitButton)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func viewWillChangeContentInsets(bottom: CGFloat) {
        scrollView.contentInset.bottom = bottom
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        scrollView.pin.all(pin.safeArea)
        formContainer.pin.width(100%)
        titleLabel.pin.hCenter().top(pin.safeArea)
        
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
        
        genderSegmentedControl.pin.below(of: creaditcardTextField)
            .horizontally()
            .margin(FormElementStyle.leftMargin)
            .marginTop(FormElementStyle.topMargin)
        
        bioTextField.pin
            .below(of: genderSegmentedControl)
            .horizontally()
            .margin(FormElementStyle.leftMargin)
            .marginTop(FormElementStyle.topMargin)
            .marginBottom(0)
        
        submitButton.pin
            .below(of: bioTextField)
            .horizontally()
            .margin(FormElementStyle.leftMargin)
            .marginTop(FormElementStyle.topMargin)
        
        formContainer.pin.wrapContent(.vertically)
        scrollView.contentSize = frame.size
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
            gender: genderSegmentedControl.selectedSegmentIndex == 0 ? .female : .male,
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
