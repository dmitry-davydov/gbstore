//
//  TabBarViewController.swift
//  GBStore
//
//  Created by Дима Давыдов on 18.07.2021.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    // MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabs()
        
        NotificationCenter.default.addObserver(self, selector: #selector(cartAdd), name: Notification.Name.Cart.Add, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(cartPay), name: Notification.Name.Cart.Pay, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Configure tab bar controller
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
        
        let cartViewController = CartViewController()
        cartViewController.tabBarItem = UITabBarItem(
            title: "Cart",
            image: UIImage.init(systemName: "cart"),
            selectedImage: UIImage.init(systemName: "cart.fill")
        )
        
        let cartViewControllerWithNavigationViewController = UINavigationController(rootViewController: cartViewController)
        cartViewControllerWithNavigationViewController.navigationBar.prefersLargeTitles = true
        
        viewControllers = [
            navigationViewControllerWrappedProductViewController,
            userProfileViewController,
            cartViewControllerWithNavigationViewController
        ]
    }
    
    //MARK: - Notification center event handlers
    @objc
    func cartAdd(_ notification: NSNotification) {
        guard let viewController = (viewControllers?[2] as? UINavigationController) else {
            return
        }
        
        viewController.tabBarItem.badgeColor = .systemRed
        viewController.tabBarItem.badgeValue = ""
    }
    
    @objc
    func cartPay(_ notification: NSNotification) {
        guard let viewController = (viewControllers?[2] as? UINavigationController) else {
            return
        }
        
        viewController.tabBarItem.badgeColor = nil
        viewController.tabBarItem.badgeValue = nil
    }
}
