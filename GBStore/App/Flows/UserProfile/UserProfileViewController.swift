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
        return view as! UserProfileView
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

// MARK: - implementation UserProfileViewInput for UserProfileViewController
extension UserProfileViewController: UserProfileViewInput {
    
    func enableSubmitButton() {
        userProfileView.enableSubmitButton()
    }
    
    func disableSubmitButton() {
        userProfileView.disableSubmitButton()
    }
}
