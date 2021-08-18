//
//  ProductReviewCellView.swift
//  GBStore
//
//  Created by Дима Давыдов on 21.07.2021.
//

import UIKit

class ProductReviewCellView: UITableViewCell {
    
    static let reuseIdentifier = "productReviewCellView"
    
    func configure(with model: ReviewListItem) {
        
        var contentConfiguration = defaultContentConfiguration()
        contentConfiguration.text = model.text
        contentConfiguration.textProperties.numberOfLines = 0
        
        self.contentConfiguration = contentConfiguration
    }
}
