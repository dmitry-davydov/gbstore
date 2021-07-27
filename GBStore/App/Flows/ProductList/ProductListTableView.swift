//
//  ProductListTableView.swift
//  GBStore
//
//  Created by Дима Давыдов on 16.07.2021.
//

import UIKit
import SnapKit

class ProductListTableView: UITableView {
    init() {
        super.init(frame: .zero, style: .plain)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        register(ProductListCellView.self, forCellReuseIdentifier: ProductListCellView.reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
