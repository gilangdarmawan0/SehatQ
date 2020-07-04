//
//  UIFormDefaultFieldSideText.swift
//  SehatQ
//
//  Created by Macbook on 08/05/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import UIKit

class UIFormDefaultFieldSideText : UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var textButton: UIButton!
    
    convenience init(text: String, tint: UIColor, font: UIFont) {
        self.init(frame: CGRect.zero)
        textButton.setTitle(text, for: .normal)
        textButton.titleLabel?.font = font
        textButton.tintColor = tint
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
        Bundle.main.loadNibNamed("UIFormDefaultFieldSideText", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
