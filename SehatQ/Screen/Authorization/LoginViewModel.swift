//
//  LoginViewModel.swift
//  SehatQ
//
//  Created by Gilang Darmawan on 02/07/20.
//  Copyright © 2020 SehatQ. All rights reserved.
//

import Foundation

// MARK: Initialize
class LoginViewModel {
    var usernameInputIsValid:((Bool, String?) -> Void)?
    var usernameInput: String = ""
    
    var passwordInputIsValid:((Bool, String?) -> Void)?
    var passwordInput: String = ""
    
    var continueButtonDidChanges:((Bool) -> Void)?
    var navigateToHomeDidChanges:((Bool, Bool) -> Void)?
    
    var shouldShowLoadingProgress: ((Bool) -> Void)?
}

// MARK: User Login
extension LoginViewModel {
    internal func setUsername(_ email: String) {
        usernameInput = email
        validateAllRequiredFieldIsNotEmpty()
        self.usernameInputIsValid!(true,nil)
    }
    
    internal func setPassword(_ password: String) {
        passwordInput = password
        validateAllRequiredFieldIsNotEmpty()
        self.passwordInputIsValid!(true,nil)
    }
    
    internal func validateAllRequiredFieldIsNotEmpty() {
        if (usernameInput == "" ||
            passwordInput == "")
        {
            self.continueButtonDidChanges!(false)
        } else {
            self.continueButtonDidChanges!(true)
        }
    }
            
    internal func loginWithUsername() {
        self.navigateToHomeDidChanges!(true, false)
    }
        
    internal func loginWithFacebook(_ token: String) {
    }
    
    internal func loginWithGoogle(_ token: String) {
    }
}

// MARK: User Profile
extension LoginViewModel {

}
