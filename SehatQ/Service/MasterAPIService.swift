//
//  MasterService.swift
//  SehatQ
//
//  Created by Gilang Darmawan on 23/04/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import UIKit

class MasterAPIService: NSObject, Requestable {
    static let instance = MasterAPIService()
    
    // Prepare the service    
    func  fetchAPI(callback: @escaping Handler) {
        request(method: .get, url: Domain.baseUrl() + APIEndpoint.home) { (result) in
            callback(result)
        }
    }
}
