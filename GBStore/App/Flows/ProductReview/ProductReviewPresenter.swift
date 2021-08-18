//
//  ProductReviewPresenter.swift
//  GBStore
//
//  Created by Дима Давыдов on 21.07.2021.
//

import UIKit

// MARK: - Presenter protocol
protocol ProductViewInput {
    func loadReview(with data: ReviewListResponse)
}

protocol ProductViewOutput {
    func viewWIllLoadReviews()
}

// MARK: - Presenter class
class ProductReviewPresenter {
    weak var viewInput: (UIViewController & ProductViewInput)?
    
    lazy var productReviewRequestFactory: ReviewsRequestFactory = {
        let requestFactory = RequestFactory()
        return requestFactory.makeReviewsRequestFavotory()
    }()
}

// MARK: - Implementation ProductViewOutput for ProductReviewPresenter
extension ProductReviewPresenter: ProductViewOutput {
    func viewWIllLoadReviews() {
        productReviewRequestFactory.list(page: 1) { [weak self] response in
            print("Load product review request")
            switch response.result {
            case .failure(let error):
                print("Load product review error \(error.localizedDescription)")
            case .success(let reviewResponse):
                print("Load product review response \(reviewResponse)")
                self?.viewInput?.loadReview(with: reviewResponse)
            }
        }
    }
}
