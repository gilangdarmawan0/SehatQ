//
//  ResponseModel.swift
//  SehatQ
//
//  Created by Gilang Darmawan on 03/07/20.
//  Copyright © 2020 SehatQ. All rights reserved.
//

import Foundation


//struct ResponseModel<T:Codable, N:Codable>:Codable {
//    let data : T?
//}

struct ResponseModel:Codable{
    let data : DashboardModel
}

struct DashboardModel:Codable{
    let category : [CategoryModel]
    let productPromo : [ProductPromoModel]
}

struct CategoryListModel:Codable {
    let category : [CategoryModel]?
}

struct CategoryModel:Codable {
    let imageUrl : String?
    let id : Int?
    let name : String?
}

struct ProductPromoListModel:Codable {
    let productPromo : [ProductPromoModel]?
}

struct ProductPromoModel:Codable {
    let imageUrl : String?
    let id : String?
    let title : String?
    let description : String?
    let price : String?
    let loved : Int?
}

