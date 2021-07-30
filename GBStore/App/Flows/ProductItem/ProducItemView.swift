//
//  ProducItemView.swift
//  GBStore
//
//  Created by Дима Давыдов on 20.07.2021.
//

import UIKit
import SnapKit

protocol MoveToReviewsDelegate: UIViewController {
    func moveToReviews()
}

class ProductItemView: UIView {
    // MARK: - UI Views
    let scrollView = UIScrollView()
    let descriptionView = UILabel()
    let priceView = UILabel()
    let reviewButton = CustomSubmitButton(height: 40, cornerRadius: 4)
    
    weak var delegate: MoveToReviewsDelegate?
    
    // MARK: - Constructor
    init() {
        super.init(frame: .zero)
        
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.numberOfLines = 0
        descriptionView.sizeToFit()
        
        priceView.font = .boldSystemFont(ofSize: 24)
        priceView.translatesAutoresizingMaskIntoConstraints = false
        
        reviewButton.setTitle("Reviews", for: .normal)
        
        addSubview(scrollView)
        
        scrollView.addSubview(priceView)
        scrollView.addSubview(descriptionView)
        scrollView.addSubview(reviewButton)
        
        reviewButton.addTarget(self, action: #selector(moveToReview), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadProduct(product: ProductResponse) {
        descriptionView.text = product.description
        priceView.text = "\(product.price)₽"
    }
    
    // MARK: - review button touchUpInside handler
    @objc
    func moveToReview(_ sender: UIButton) {
        delegate?.moveToReviews()
    }
    
    // MARK: - Layout subview
    override func layoutSubviews() {
        super.layoutSubviews()
        
        scrollView.snp.remakeConstraints { [weak self] make in
            guard let self = self else { return }
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(FormElementStyle.viewTopOffset)
            make.leading.equalToSuperview().offset(FormElementStyle.leftMargin)
            make.trailing.equalToSuperview().offset(-FormElementStyle.leftMargin)
            make.bottom.equalToSuperview()
        }
        
        descriptionView.snp.remakeConstraints { make in
            make.top.equalTo(scrollView)
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            
            make.width.equalTo(UIApplication.shared.windows[0].frame.width - FormElementStyle.leftMargin * 2)
        }
        
        priceView.snp.remakeConstraints { make in
            make.top.equalTo(descriptionView.snp.bottom).offset(FormElementStyle.viewTopOffset)
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        reviewButton.snp.remakeConstraints { make in
            make.top.equalTo(priceView.snp.bottom).offset(FormElementStyle.leftMargin)
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
        }
    }
}
