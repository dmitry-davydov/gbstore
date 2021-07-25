//
//  CartView.swift
//  GBStore
//
//  Created by Дима Давыдов on 24.07.2021.
//

import UIKit
import SnapKit

protocol CartViewDelegate {
    func buyButtonDidTapped(_ sender: UIButton)
}

class CartView: UIView {
    
    var totalPrice: Int = 0 {
        didSet {
            totalLabel.text = "Price \(totalPrice)₽"
        }
    }
    
    // MARK: - UI views
    let tableView = UITableView()

    private let totalLabel = UILabel()
    private let tableHeaderLabel = UILabel()
    private let stackView = UIStackView()
    private let buyButton = CustomSubmitButton(height: 40, cornerRadius: 4)
    
    var delegate: CartViewDelegate?
    
    init() {
        super.init(frame: .zero)
        
        tableView.register(CartTableCell.self, forCellReuseIdentifier: CartTableCell.reuseIdentifier)
        
        buyButton.setTitle("Buy", for: .normal)
        
        totalLabel.text = "Total: 0₽"
        totalLabel.font = .systemFont(ofSize: 18, weight: .bold)
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.addArrangedSubview(totalLabel)
        stackView.addArrangedSubview(buyButton)
        
        addSubview(stackView)
        addSubview(tableView)
        
        tableHeaderLabel.text = "Products"
        tableHeaderLabel.font = .systemFont(ofSize: 24, weight: .bold)
        
        addSubview(tableHeaderLabel)
        
        buyButton.addTarget(self, action: #selector(buyButtonDidTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateTotal(_ total: Int) {
        totalPrice = total
    }
    
    @objc
    private func buyButtonDidTapped(_ sender: UIButton) {
        delegate?.buyButtonDidTapped(sender)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        stackView.snp.remakeConstraints { make in
            make.top.equalTo(self.safeAreaInsets.top)
            make.height.equalTo(40)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        tableHeaderLabel.snp.remakeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(22)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        tableView.snp.remakeConstraints { make in
            make.top.equalTo(tableHeaderLabel.snp.bottom).offset(12)
            make.bottom.equalTo(self.safeAreaInsets.bottom).offset(-12)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
}
