//
//  UIWhiteHeader.swift
//  SehatQ
//
//  Created by Macbook on 29/04/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import Foundation
import UIKit

@objc protocol UIBackHeaderDelegate: class {
    @objc func onBackNavigation(_ sender:UIBarButtonItem!)
}

class UIBackHeader {
    weak private var uiBackHeaderDelegate : UIBackHeaderDelegate?
    func set(
        viewController : UIViewController
    ) {
        let leftButton : UIBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: viewController, action: #selector(uiBackHeaderDelegate?.onBackNavigation(_:)))
        leftButton.tintColor = UIColor.steelGrey
        viewController.navigationController?.navigationBar.backgroundColor = UIColor.clear
        leftButton.image = ImageAsset.ic_back
        viewController.navigationItem.leftBarButtonItem = leftButton
    }
}
