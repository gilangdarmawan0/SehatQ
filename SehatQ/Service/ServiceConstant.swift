//
//  ServiceConstant.swift
//  SehatQ
//
//  Created by Gilang Darmawan on 23/04/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//
 
import UIKit

struct Domain {
    static let dev = "https://private-4639ce-ecommerce56.apiary-mock.com/"
}

extension Domain {
    static func baseUrl() -> String {
        return Domain.dev
    }
}

struct APIEndpoint {
    static let home         = "home"
}

enum HTTPHeaderField: String {
    case authentication  = "Authorization"
    case contentType     = "Content-Type"
    case acceptType      = "Accept"
    case acceptEncoding  = "Accept-Encoding"
    case acceptLangauge  = "Accept-Language"
}

enum ContentType: String {
    case json            = "application/json"
    case multipart       = "multipart/form-data"
    case ENUS            = "en-us"
}

enum MultipartType: String {
    case image = "Image"
    case csv = "CSV"
}

enum MimeType: String {
    case image = "image/png"
    case csvText = "text/csv"
}

enum UploadType: String {
    case avatar
    case file
}
