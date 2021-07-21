//
//  ProductItemViewController.swift
//  GBStore
//
//  Created by Дима Давыдов on 20.07.2021.
//

import UIKit

class ProductItemViewController: UIViewController {
    
    var productId: ProductID?
    var presenter = ProductItemPresenter()
    
    private var productItemView: ProductItemView {
        guard let productItemView = (view as? ProductItemView) else {
            fatalError("View is not instance of ProductItemView")
        }
        
        return productItemView
    }
    
    // MARK: - View Controller lifecycle
    override func loadView() {
        presenter.viewInput = self
        let productItemView = ProductItemView()
        productItemView.delegate = self
        view = productItemView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let productId = productId {
            presenter.viewDidLoadProductItem(productId: productId)
        }
    }
}

// MARK: - Implementation ProductItemViewInput for ProductItemViewController
extension ProductItemViewController: ProductItemViewInput {
    
    func loadProductItem(response: ProductResponse) {
        title = response.name
        
        productItemView.loadProduct(product: response)
    }
}

// MARK: - MoveToReviewsDelegate implementation
extension ProductItemViewController: MoveToReviewsDelegate {
    func moveToReviews() {
        guard let productId = productId else {
            return
        }
        
        presenter.viewWillShowReviews(productId: productId)
    }
}
