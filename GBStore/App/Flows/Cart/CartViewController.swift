//
//  CartViewController.swift
//  GBStore
//
//  Created by Дима Давыдов on 24.07.2021.
//

import UIKit

class CartViewController: UIViewController {
    
    var presenter: CartPresenter?
    var cartItems: [ProductResponse] = []
    
    var cartView: CartView {
        guard let cartView = view as? CartView else {
            fatalError("view is not instance of CartView")
        }
        
        return cartView
    }
    
    // MARK: - ViewController lifecycle
    override func loadView() {
        let cartView = CartView()
        cartView.delegate = self
        cartView.tableView.dataSource = self
        cartView.tableView.delegate = self
        
        view = cartView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let presenter = CartPresenter()
        presenter.viewInput = self
        self.presenter = presenter
        
        title = "Cart"
        
        NotificationCenter.default.addObserver(self, selector: #selector(onCartPay), name: Notification.Name.Cart.Pay, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let presenter = presenter else {
            return
        }
        cartItems = presenter.userBasketService.allProducts()
        cartView.updateTotal(presenter.userBasketService.totalCost())
        cartView.tableView.reloadData()
    }
    
    // MARK: - Notification center cart.pay event handler
    @objc
    func onCartPay(_ notification: NSNotification) {
        guard let presenter = presenter else {
            return
        }
        
        cartView.updateTotal(presenter.userBasketService.totalCost())
        cartView.tableView.reloadData()
    }
}

// MARK: - UI table view delegate
extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UI Table view data source delegate
extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.userBasketService.allProducts().count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartTableCell.reuseIdentifier) as? CartTableCell else {
            fatalError("Cell is not instance of CartTableCell")
        }
        
        cell.configure(with: cartItems[indexPath.row])
        
        return cell
    }
}


// MARK: - CartViewDelegate
extension CartViewController: CartViewDelegate {
    func buyButtonDidTapped(_ sender: UIButton) {
        presenter?.buyButtonPressed()
    }
}

// MARK: - presenter View Input protocol implementation
extension CartViewController: CartViewInput {}
