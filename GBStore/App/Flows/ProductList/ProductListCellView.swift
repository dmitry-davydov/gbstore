//
//  ProductListCellView.swift
//  GBStore
//
//  Created by Дима Давыдов on 16.07.2021.
//

import UIKit

class ProductListCellView: UITableViewCell {
    static let reuseIdentifier = "productListCellView"
    
    func configure(with model: ProductListItem) {
        
        var contentConfiguration = defaultContentConfiguration()
        contentConfiguration.text = model.name
        contentConfiguration.secondaryText = "\(model.price)"
        
        self.contentConfiguration = contentConfiguration
    }
}
