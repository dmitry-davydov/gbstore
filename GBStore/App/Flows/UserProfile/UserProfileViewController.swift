//
//  UserProfileViewController.swift
//  GBStore
//
//  Created by Дима Давыдов on 14.07.2021.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    var userModel: UserResponse?
    
    override func loadView() {
        let presenter = UserProfilePresenter()
        presenter.viewInput = self
        view = UserProfileView(presenter: presenter, userModel: userModel)
    }
    
    private var userProfileView: UserProfileView {
        guard let userProfileView = (view as? UserProfileView) else {
            fatalError("View does not instance of UserProfileView")
        }
        
        return userProfileView
    }
    
    // MARK: - View Controller lifecycle
    
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
            userProfileView.viewWillChangeContentInsets(bottom: 0)
        } else {
            userProfileView.viewWillChangeContentInsets(bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom)
        }
    }
    
    // MARK: - Tap gesture handler
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - implementation UserProfileViewInput for UserProfileViewController
extension UserProfileViewController: UserProfileViewInput {
    
    func enableSubmitButton() {
        userProfileView.enableSubmitButton()
    }
    
    func disableSubmitButton() {
        userProfileView.disableSubmitButton()
    }
}
