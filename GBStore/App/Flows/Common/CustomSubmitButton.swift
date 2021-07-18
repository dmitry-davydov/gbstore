//
//  CustomSubmitButton.swift
//  GBStore
//
//  Created by Дима Давыдов on 17.07.2021.
//

import UIKit
import PinLayout

class CustomSubmitButton: UIButton {
    
    let buttonHeight: CGFloat
    let buttonCornerRadius: CGFloat
    
    init(height: CGFloat, cornerRadius: CGFloat) {
        buttonHeight = height
        buttonCornerRadius = cornerRadius
        
        super.init(frame: .zero)
        
        backgroundColor = .gray
        self.pin.height(height)
        layer.cornerRadius = buttonCornerRadius
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
