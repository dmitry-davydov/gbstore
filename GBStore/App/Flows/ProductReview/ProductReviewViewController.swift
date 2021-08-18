//
//  ProductReviewViewController.swift
//  GBStore
//
//  Created by Дима Давыдов on 21.07.2021.
//

import UIKit

class ProductReviewViewController: UIViewController {
    var productId: ProductID?
    
    private var reviewList: [ReviewListItem] = []
    private var presenter: ProductReviewPresenter?
    
    let tableView = ProductReviewView()
    
    // MARK: - View Controller lifecycle
    override func loadView() {
        super.loadView()
        
        let presenter = ProductReviewPresenter()
        presenter.viewInput = self
        
        self.presenter = presenter
        view.addSubview(tableView)
        
        tableView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        presenter?.viewWIllLoadReviews()
    }
}

// MARK: - Table view delegate
extension ProductReviewViewController: UITableViewDelegate {}

// MARK: - Table view data source delegate
extension ProductReviewViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductReviewCellView.reuseIdentifier) as? ProductReviewCellView else {
            fatalError("The dequeued cell is not an instance of ProductReviewCellView.")
        }
        
        cell.configure(with: reviewList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

// MARK: - Presenter view input implementation
extension ProductReviewViewController: ProductViewInput {
    func loadReview(with data: ReviewListResponse) {
        reviewList = data
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
} 
