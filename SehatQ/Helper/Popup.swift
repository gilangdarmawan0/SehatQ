//
//  Popup.swift
//  SehatQ
//
//  Created by Macbook on 13/05/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import UIKit

final class Popup {
    enum Context {
        static let popup1                   = Popup.Storyboard(id: "uiPopup1", name: "UIPopup1")
    }
    
    struct Storyboard {
        let id: String
        let name: String
    }
    
    static func initViewController(_ storyboard : Popup.Storyboard) -> UIViewController {
        return UIStoryboard.init(name: storyboard.name, bundle: Bundle.main).instantiateViewController(withIdentifier: storyboard.id) as UIViewController
    }
    
    static func show(storyboard : Popup.Storyboard? = nil, viewController : UIViewController, targetViewController: UIViewController? = nil) {
        if (targetViewController != nil) {
            targetViewController!.modalTransitionStyle = .crossDissolve;
            targetViewController!.modalPresentationStyle = .overCurrentContext;
            viewController.navigationController?.present(targetViewController!, animated: true, completion: nil)
        } else if (storyboard != nil) {
            let vc = UIStoryboard.init(name: storyboard!.name, bundle: Bundle.main).instantiateViewController(withIdentifier: storyboard!.id) as UIViewController
            vc.modalTransitionStyle = .crossDissolve;
            vc.modalPresentationStyle = .overCurrentContext;
            viewController.navigationController?.present(vc, animated: true, completion: nil)
        }
    }
    
    static func dismiss(viewController : UIViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
}
