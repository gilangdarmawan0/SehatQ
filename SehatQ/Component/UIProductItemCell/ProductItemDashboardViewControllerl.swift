//
//  ProductItemDashboardViewControllerl.swift
//  SehatQ
//
//  Created by Gilang Darmawan on 02/07/20.
//  Copyright © 2020 SehatQ. All rights reserved.
//

import UIKit

class ProductItemDashboardViewControllerl: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var favouriteCheck: UICheckmark!
    @IBOutlet weak var productName: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    @IBAction func favouriteClicked(_ sender: Any) {
        self.favouriteCheck.change()
    }
}
