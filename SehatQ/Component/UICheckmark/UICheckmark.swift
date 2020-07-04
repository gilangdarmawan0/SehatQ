//
//  UICheckmark.swift
//  SehatQ
//
//  Created by Macbook on 30/04/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import UIKit

class UICheckmark : UIButton {
    enum CheckState {
        case checked
        case unchecked
    }

    enum Tyoe {
        case agreement
        case favourite
    }

    var currentState : CheckState = CheckState.unchecked
    var type : Tyoe = Tyoe.favourite
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        currentState = CheckState.unchecked
        if (type == .favourite){
            setImage(ImageAsset.ic_love_empty, for: .normal)
        }else{
            setImage(ImageAsset.ic_checkOff, for: .normal)
        }
    }

    func change() {
        if (currentState == CheckState.unchecked) {
            check()
        } else if (currentState == CheckState.checked) {
            uncheck()
        }
    }
    
    func check() {
        if (type == .favourite){
            setImage(ImageAsset.ic_love_fill, for: .normal)
        }else{
            setImage(ImageAsset.ic_checkOn, for: .normal)
        }
        currentState = CheckState.checked
    }
    
    func uncheck() {
        if (type == .favourite){
            setImage(ImageAsset.ic_love_empty, for: .normal)
        }else{
            setImage(ImageAsset.ic_checkOff, for: .normal)
        }
        currentState = CheckState.unchecked
    }
}
