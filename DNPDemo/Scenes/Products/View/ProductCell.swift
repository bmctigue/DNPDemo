//
//  ProductCollectionViewCell.swift
//  DNPDemo
//
//  Created by Bruce McTigue on 4/6/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import UIKit
import Tiguer
import ChameleonFramework

class ProductCell: UICollectionViewCell {
    
    static let bidText = "Bid"
    static let sellText = "Sell"

    typealias ViewModel = Products.ViewModel
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bidButton: UIButton!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var progressView: UIProgressView!
    
    var productId: String = ""
    
    var productState: ProductState? {
        didSet {
            if let productState = productState {
                self.productStateChanged(productState)
            }
        }
    }
    
    lazy var dynamicProductState: DynamicValue<ProductState?> = DynamicValue(productState)
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 8.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = FlatGrayDark().cgColor
        self.bidButton.layer.cornerRadius = 8.0
        self.bidButton.layer.borderWidth = 1.0
        self.bidButton.layer.borderColor = FlatGrayDark().cgColor
    }
    
    @IBAction func bidButtonPressed(_ sender: Any) {
        if let state = productState {
            switch state {
            case .bid:
                self.productState = .once
            case .once:
                self.productState = .twice
            case .twice:
                self.productState = .sold
            case .sold:
                self.productState = .bid
            }
            dynamicProductState.value = productState
        }
    }
    
    func productStateChanged(_ state: ProductState) {
        switch state {
        case .bid:
            progressView.progressTintColor = .flatGreen
            bidButton.setTitle(ProductCell.bidText, for: .normal)
        case .once:
            progressView.progressTintColor = .flatOrange
            bidButton.setTitle(ProductCell.bidText, for: .normal)
        case .twice:
            progressView.progressTintColor = .flatRed
            bidButton.setTitle(ProductCell.bidText, for: .normal)
        case .sold:
            progressView.progressTintColor = .flatGray
            bidButton.setTitle(ProductCell.sellText, for: .normal)
        }
        progressView.progress = 1.0
    }
}
