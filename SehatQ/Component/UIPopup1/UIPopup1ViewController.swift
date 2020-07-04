//
//  UIPopup1ViewController.swift
//  SehatQ
//
//  Created by Macbook on 13/05/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import UIKit

class UIPopup1ViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var container: UIView!
    
    var imageMain : UIImage? = nil
    var labelMain : String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        image.image = imageMain
        label.text = labelMain
        
        styling()
    }
    
    private func styling() {
        label.style(style: TextStyle.textRegular)
        container.layer.cornerRadius = 5;
        container.layer.masksToBounds = true;
    }
}
