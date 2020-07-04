//
//  Navigator.swift
//  SehatQ
//
//  Created by Macbook on 30/04/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import UIKit

final class Navigator {
    enum Screen {
        static let homeDashboard                = Navigator.Storyboard(id: "home", name: "Home")
        static let productDetail                = Navigator.Storyboard(id: "productDetail", name: "ProductDetail")
        static let productHistory               = Navigator.Storyboard(id: "productHistory", name: "ProductHistory")
        static let productSearch                = Navigator.Storyboard(id: "productSearch", name: "ProductSearch")
        static let login                        = Navigator.Storyboard(id: "login", name: "Login")
    }
    
    struct Storyboard {
        let id: String
        let name: String
    }
    
    static func initViewController(_ storyboard : Navigator.Storyboard) -> UIViewController {
        return UIStoryboard.init(name: storyboard.name, bundle: Bundle.main).instantiateViewController(withIdentifier: storyboard.id) as UIViewController
    }
    
    static func push(storyboard : Navigator.Storyboard? = nil, viewController : UIViewController, targetViewController: UIViewController? = nil, animated: Bool) {
        if (targetViewController != nil) {
            viewController.navigationController?.pushViewController(targetViewController!, animated: animated)
        } else if (storyboard != nil) {
            let vc = UIStoryboard.init(name: storyboard!.name, bundle: Bundle.main).instantiateViewController(withIdentifier: storyboard!.id) as UIViewController
            viewController.navigationController?.pushViewController(vc, animated: animated)
        }
    }
    
    static func backToRoot(_ viewController: UIViewController) {
        // TODO: Change this later?
        push(storyboard: Navigator.Screen.homeDashboard, viewController: viewController, animated: true)
    }
    
    static func pop(viewController : UIViewController, animated: Bool) {
        viewController.navigationController?.popViewController(animated: animated)
    }
}
