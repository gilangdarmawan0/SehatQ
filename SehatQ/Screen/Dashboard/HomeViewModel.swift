//
//  HomeViewModel.swift
//  SehatQ
//
//  Created by Gilang Darmawan on 02/07/20.
//  Copyright © 2020 SehatQ. All rights reserved.
//

import Foundation

// MARK: Initialize
class HomeViewModel {
    internal var dataDidChanges: ((Bool, Bool) -> Void)?
    
    internal var response:[ResponseModel]? {
        didSet {
            self.dataDidChanges!(true, false)
        }
    }
}

// MARK: Product Dashboard
extension HomeViewModel {
    internal func fetchApiList() {
        MasterAPIService.instance.fetchAPI { result in
            switch result {
            case .success(let data):
                let mappedModel = try? JSONDecoder().decode([ResponseModel].self, from: data) as [ResponseModel]
                print(mappedModel ?? "")
                self.response = mappedModel
                break
            case .failure(let error):
                self.response = nil
            }
        }
    }

}
