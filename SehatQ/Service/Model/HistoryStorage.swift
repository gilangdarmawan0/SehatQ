//
//  HistoryStorage.swift
//  SehatQ
//
//  Created by Gilang Darmawan on 03/07/20.
//  Copyright © 2020 SehatQ. All rights reserved.
//

import Foundation

class HistoryStorage {
    static let instance = HistoryStorage()
    // MARK: Device Identifier
    
    func getHistoryListProduct() -> [ProductPromoModel]? {
        let profileString = UserDefaults.standard.string(forKey: "HistoryProduct")
        guard profileString != nil else {
            let productHistory = [ProductPromoModel]()
            return productHistory
        }
        let jsonData = profileString!.data(using: .utf8)!
        let decoder = JSONDecoder()
        let userProfile = try! decoder.decode([ProductPromoModel]?.self, from: jsonData) //{
        
        return userProfile
//        } else {
//            let productHistory = [ProductPromoModel]()
//            return productHistory
//        }
//        let userProfile = try! decoder.decode([ProductPromoModel].self, from: jsonData)
//        return userProfile
    }

    func storeHistoryProduct(_ product: ProductPromoModel) {
        var productList = getHistoryListProduct()
        productList?.append(product)
        
        let encoder = JSONEncoder()
        let data = try! encoder.encode(productList)
        UserDefaults.standard.set(String(data: data, encoding: .utf8)!, forKey: "HistoryProduct")
    }
}
