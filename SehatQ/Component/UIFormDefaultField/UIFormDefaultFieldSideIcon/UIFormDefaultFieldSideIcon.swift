//
//  UIFormDefaultFieldSideIcon.swift
//  SehatQ
//
//  Created by Macbook on 08/05/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import UIKit

class UIFormDefaultFieldSideIcon : UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var iconButton: UIButton!
    
    convenience init(icon: UIImage, tint: UIColor) {
        self.init(frame: CGRect.zero)
        iconButton.setImage(icon, for: .normal)
        iconButton.imageView?.contentMode = .scaleAspectFit
        iconButton.tintColor = tint
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        Bundle.main.loadNibNamed("UIFormDefaultFieldSideIcon", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
}
