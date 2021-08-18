//
//  ProductListViewController.swift
//  GBStore
//
//  Created by Дима Давыдов on 16.07.2021.
//

import UIKit
import Firebase

class ProductListViewController: UIViewController {
    private var productList: [Int: [ProductListItem]] = [:]
    private var page = 0
    
    let tableView = ProductListTableView()
    var presenter: ProductListPresenter?
    
    // MARK: - View Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Products"
        
        let presenter = ProductListPresenter()
        presenter.viewInput = self
        self.presenter = presenter
        
        tableView.dataSource = self
        tableView.delegate = self
        presenter.viewWillLoadTableData(categoryId: 1, page: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Analytics.logEvent("Open product list", parameters: nil)
    }
}

// MARK: - ProductListViewInput implementation for ProductListViewController
extension ProductListViewController: ProductListViewInput {
    func reloadTableView(with data: ProductListResponse) {
        productList[data.page_number] = data.products
        page = data.page_number
        
        tableView.reloadData()
    }
}

extension ProductListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        guard let productListItem = productList[page]?[indexPath.row] else {
            return
        }
        
        presenter?.viewWillMoveToProductItem(productId: productListItem.id)
    }
}

// MARK: - UITableViewDataSource implementation for ProductListViewController
extension ProductListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let productListItem = productList[page]?[indexPath.row] else {
            return ProductListCellView()
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductListCellView.reuseIdentifier) as? ProductListCellView else {
            fatalError("The dequeued cell is not an instance of ProductListCellView.")
        }
        
        cell.configure(with: productListItem)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList[page]?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
