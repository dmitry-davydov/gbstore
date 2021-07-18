//
//  TabBarViewController.swift
//  GBStore
//
//  Created by Дима Давыдов on 18.07.2021.
//

import UIKit

class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabs()
    }
    
    private func configureTabs() {
        let productsViewController = ProductListViewController()
        productsViewController.tabBarItem = UITabBarItem(
            title: "Products",
            image: UIImage.init(systemName: "bag"),
            selectedImage: UIImage.init(systemName: "bag.fill")
        )
        
        let navigationViewControllerWrappedProductViewController = UINavigationController(rootViewController: productsViewController)
        
        let userProfileViewController = UserProfileViewController()
        userProfileViewController.userModel = UserSession.shared.user
        userProfileViewController.tabBarItem = UITabBarItem(
            title: "User",
            image: UIImage.init(systemName: "person"),
            selectedImage: UIImage.init(systemName: "person.fill")
        )
        
        viewControllers = [navigationViewControllerWrappedProductViewController, userProfileViewController]
    }
}
