//
//  ProductReviewView.swift
//  GBStore
//
//  Created by Дима Давыдов on 21.07.2021.
//

import UIKit
import SnapKit

class ProductReviewView: UITableView {
    init() {
        super.init(frame: .zero, style: .plain)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        register(ProductReviewCellView.self, forCellReuseIdentifier: ProductReviewCellView.reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.snp.remakeConstraints { make in
            make.top.equalTo(0)
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
