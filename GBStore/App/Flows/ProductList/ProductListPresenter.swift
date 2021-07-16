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
        productRequestFactory.all(model: ProductCollectionRequest(categoryId: categoryId, page: page)) { [weak self] response in
            switch response.result {
            case .success(let productList):
                DispatchQueue.main.async {
                    self?.viewInput?.reloadTableView(with: productList)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
