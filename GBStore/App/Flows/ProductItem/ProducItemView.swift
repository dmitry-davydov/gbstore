//
//  ProducItemView.swift
//  GBStore
//
//  Created by Дима Давыдов on 20.07.2021.
//

import UIKit
import SnapKit

protocol ProductItemViewDelegate: UIViewController {
    func moveToReviews()
    func addToCart()
}

class ProductItemView: UIView {
    // MARK: - UI Views
    let scrollView = UIScrollView()
    let descriptionView = UILabel()
    let priceView = UILabel()
    let reviewButton = CustomSubmitButton(height: 40, cornerRadius: 4)
    let addToCartButton = UIButton()
    
    weak var delegate: ProductItemViewDelegate?
    
    //MARK: - add to cart constants
    private let addToCartButtonСornderRadius: CGFloat = 12
    private let addToCartButtonWidth: CGFloat = 80
    
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
        
        addToCartButton.backgroundColor = .lightGray
        addToCartButton.layer.cornerRadius = addToCartButtonСornderRadius
        addToCartButton.setTitle("Buy", for: .normal)
        
        scrollView.addSubview(addToCartButton)
        
        scrollView.addSubview(priceView)
        scrollView.addSubview(descriptionView)
        scrollView.addSubview(reviewButton)
        
        reviewButton.addTarget(self, action: #selector(moveToReview), for: .touchUpInside)
        addToCartButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
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
    
    @objc
    func addToCart(_ sender: UIButton) {
        delegate?.addToCart()
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
        
        addToCartButton.snp.remakeConstraints { [weak self] make in
            guard let self = self else {
                return
            }
            make.centerY.equalTo(priceView.snp.centerY)
            make.width.equalTo(self.addToCartButtonWidth)
            make.trailing.equalToSuperview()
        }
        
        reviewButton.snp.remakeConstraints { make in
            make.top.equalTo(priceView.snp.bottom).offset(FormElementStyle.leftMargin)
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
        }
    }
}
