//
//  PortofolioItemVC.swift
//  SehatQ
//
//  Created by Gilang Darmawan on 02/07/20.
//  Copyright © 2020 SehatQ. All rights reserved.
//

import UIKit

class ProductItemViewController: UITableViewCell {
  
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPrice: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
