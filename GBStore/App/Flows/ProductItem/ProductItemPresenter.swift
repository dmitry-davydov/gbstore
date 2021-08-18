//
//  ProductItemPresenter.swift
//  GBStore
//
//  Created by Дима Давыдов on 20.07.2021.
//

import UIKit

// MARK: - Presenter protocols
protocol ProductItemViewInput {
    func loadProductItem(response: ProductResponse)
}

protocol ProductItemViewOutput {
    func viewDidLoadProductItem(productId: ProductID)
    func viewWillShowReviews(productId: ProductID)
    func viewWillAddToCart(product: ProductResponse)
}

// MARK: - Product item presenter
class ProductItemPresenter {
    
    weak var viewInput: (UIViewController & ProductItemViewInput)?
    
    lazy var productRequestFactory: ProductRequestFactory = {
        let requestFactory = RequestFactory()
        return requestFactory.makeProductRequestFactory()
    }()
    
    lazy var userBasketService: UserBasketProtocol = {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
              let userBasket = appDelegate.container.resolve(UserBasketProtocol.self) else {
            fatalError("Can not resolve container")
        }
        
        return userBasket
    }()
}

// MARK: - View output protocol implementation
extension ProductItemPresenter: ProductItemViewOutput {
    func viewWillShowReviews(productId: ProductID) {
        
        let reviewViewController = ProductReviewViewController()
        reviewViewController.productId = productId
        reviewViewController.modalPresentationStyle = .popover
        reviewViewController.title = "Reviews"
        let navigationViewController = UINavigationController(rootViewController: reviewViewController)
        
        viewInput?.present(navigationViewController, animated: true, completion: nil)
    }
    
    func viewDidLoadProductItem(productId: ProductID) {
        
        productRequestFactory.one(id: productId) { [weak self] response in
            print("Load product item request for productID: \(productId)")
            switch response.result {
            case .failure(let error):
                print("Load product item response error \(error.localizedDescription)")
            case .success(let productResponse):
                print("Load product item response data \(productResponse)")
                DispatchQueue.main.async {
                    self?.viewInput?.loadProductItem(response: productResponse)
                }
            }
        }
    }
    
    func viewWillAddToCart(product: ProductResponse) {
        userBasketService.add(product: product)
    }
}
