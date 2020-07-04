//
//  ProductItemHorizontalViewController.swift
//  SehatQ
//
//  Created by Gilang Darmawan on 02/07/20.
//  Copyright © 2020 SehatQ. All rights reserved.
//

import UIKit

class ProductItemHorizontalViewController: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var productCategoryImage: UIImageView!
    @IBOutlet weak var productCategory: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
