//
//  CartTableCell.swift
//  GBStore
//
//  Created by Дима Давыдов on 24.07.2021.
//

import UIKit

class CartTableCell: UITableViewCell {
    
    static let reuseIdentifier = "cartCellView"
    
    func configure(with model: ProductResponse) {
        
        var contentConfiguration = defaultContentConfiguration()
        contentConfiguration.text = model.name
        contentConfiguration.secondaryText = "\(model.price)"
        
        self.contentConfiguration = contentConfiguration
    }
}
