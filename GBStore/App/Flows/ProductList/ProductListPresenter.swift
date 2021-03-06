//
//  ProductListPresenter.swift
//  GBStore
//
//  Created by Дима Давыдов on 16.07.2021.
//

import UIKit

// MARK: - Presenter protocols
protocol ProductListViewInput {
    func reloadTableView(with data: ProductListResponse)
}

protocol ProductListViewOutput {
    func viewWillLoadTableData(categoryId: Int, page: Int)
    func viewWillMoveToProductItem(productId: ProductID)
}

// MARK: - Presenter class
class ProductListPresenter {
    weak var viewInput: (UIViewController & ProductListViewInput)?
    lazy var productRequestFactory: ProductRequestFactory = {
        let requestFactory = RequestFactory()
        
        return requestFactory.makeProductRequestFactory()
    }()
}

// MARK: - Implementation of ViewOutput protocol for Presenter
extension ProductListPresenter: ProductListViewOutput {
    func viewWillLoadTableData(categoryId: Int, page: Int) {
        let model = ProductCollectionRequest(categoryId: categoryId, page: page)
        print("Product list request with data: \(model)")
        productRequestFactory.all(model: model) { [weak self] response in
            switch response.result {
            case .success(let productList):
                print("Product list success response: \(productList)")
                DispatchQueue.main.async {
                    self?.viewInput?.reloadTableView(with: productList)
                }
            case .failure(let error):
                print("Product list error response: \(error.localizedDescription)")
            }
        }
    }
    
    func viewWillMoveToProductItem(productId: ProductID) {
        let productItemViewController = ProductItemViewController()
        productItemViewController.productId = productId
        
        viewInput?.navigationController?.pushViewController(productItemViewController, animated: true)
    }
}
