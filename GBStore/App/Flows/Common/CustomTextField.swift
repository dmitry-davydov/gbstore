//
//  CustomTextField.swift
//  GBStore
//
//  Created by Дима Давыдов on 17.07.2021.
//

import UIKit
import PinLayout

class CustomTextField: UITextField {
    
    let textFieldHeight: CGFloat
    let textFieldCornerRadius: CGFloat = 4
    let textFieldPlaceholderPadding = 12
    
    init(height: CGFloat) {
        self.textFieldHeight = height
        super.init(frame: .zero)
        
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = textFieldCornerRadius
        
        leftView = UIView.init(frame: CGRect(x: 0, y: 0, width: textFieldPlaceholderPadding, height: Int(textFieldHeight)))
        leftViewMode = .always
        self.pin.height(textFieldHeight)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
