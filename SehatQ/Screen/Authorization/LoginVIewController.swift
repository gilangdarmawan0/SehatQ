//
//  LoginVIewController.swift
//  SehatQ
//
//  Created by Gilang Darmawan on 02/07/20.
//  Copyright © 2020 SehatQ. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKLoginKit

class LoginViewController: UIViewController {
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var usernameField: UIFormDefaultField!
    @IBOutlet weak var passwprdFIeld: UIFormDefaultField!
    @IBOutlet weak var rememberMe: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var FacebookButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var rememberMeCheck: UICheckmark!
    
    private let viewModel = LoginViewModel()
    private let passwordVisibilityOffView = UIFormDefaultFieldSideIcon(icon: ImageAsset.ic_visibleOff!, tint: .blueyGrey)
    private let passwordVisibilityOnView = UIFormDefaultFieldSideIcon(icon: ImageAsset.ic_visibleOn!, tint: .blueyGrey)
    private var passwordVisibilityOn : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        setUpObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
        
}

// MARK: Prepare UI
extension LoginViewController {
    private func prepareUI() {
        prepareView()
        prepareLabel()
        prepareButton()
        prepareField()
        prepareCheckBox()
    }
    
    private func prepareView(){
        loginButton.setTitle("Sign In", for: .normal)
        loginButton.isEnabled = false
        loginButton?.style(style: TextStyle.labelWhite)
        loginButton?.style(style: ViewStyle.Button.main)
    }
    
    private func prepareLabel(){
        headerTitle.text = "LOGIN"
        headerTitle.style(style: TextStyle.titleBold)
        rememberMe.text = "Remember Me"
        rememberMe.style(style: TextStyle.textRegular12)
    }
    
    private func prepareButton(){
        setContinueButtonDisabled()
        googleButton.setImage(ImageAsset.ic_googleSignIn, for: .normal)
        FacebookButton.setImage(ImageAsset.ic_facebookSignIn, for: .normal)
    }
    
    private func prepareField(){
        usernameField.setState(state: UIFormDefaultField.FormState.normal)
        usernameField.setFieldLabelText(labelText: "Username")
        usernameField.setFieldPlaceholderText(placeholderText: "Username")
        usernameField.formField.addTarget(self, action: #selector(userNameTextFieldDidChange(_:)), for: .editingChanged)
        
        passwprdFIeld.setState(state: UIFormDefaultField.FormState.normal)
        passwprdFIeld.setFieldLabelText(labelText: "Password")
        passwprdFIeld.setFieldPlaceholderText(placeholderText: "Password")
        passwprdFIeld.setSecureTextEntry(value: true)
        passwordVisibilityOffView.iconButton.addTarget(self, action: #selector(passwordVisibilityTapped(_:)), for: .touchUpInside)
        passwordVisibilityOnView.iconButton.addTarget(self, action: #selector(passwordVisibilityTapped(_:)), for: .touchUpInside)
        passwprdFIeld.setSideIcon(
            view: passwordVisibilityOffView
        )
        passwprdFIeld.formField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func prepareCheckBox(){
        self.rememberMeCheck.setCheckBoxType(type: .agreement)
    }
}

// MARK: Actions
extension LoginViewController {
    @IBAction func facebookLoginClicked(_ sender: Any) {
        promptFacebookAccountUI()
    }
    
    @IBAction func googleLoginClicked(_ sender: Any) {
        promptGoogleAccountUI()
    }
    
    @IBAction func userLoginClicked(_ sender: Any) {
        viewModel.loginWithUsername()
    }
    
    @IBAction func rememberMeClicked(_ sender: Any) {
        self.rememberMeCheck.change()
    }
    
    @objc private func passwordVisibilityTapped(_ sender: Any) {
        switch passwordVisibilityOn{
        case true:
            setPasswordVisibilityOff()
        case false:
            setPasswordVisibilityOn()
        }
    }
    
    @objc private func userNameTextFieldDidChange(_ sender: Any) {
         viewModel.setUsername(usernameField.getValue())
    }
     
    @objc private func passwordTextFieldDidChange(_ sender: Any) {
         viewModel.setPassword(passwprdFIeld.getValue())
    }
}

// MARK: Methods
extension LoginViewController {
    private func setUpObserver() {
        viewModel.navigateToHomeDidChanges = { (success, fail) in
            if (success) {
                self.setIsLogin()
                self.navigateToHome()
            }
        }
        
        viewModel.continueButtonDidChanges = { (enabled) in
            if (enabled) {
                self.setContinueButtonEnabled()
            } else {
                self.setContinueButtonDisabled()
            }
        }
        
        viewModel.usernameInputIsValid = { (isValid, error) in
            if (isValid) {
                self.setFormNormal(field: self.usernameField)
            } else {
                self.setFormError(field: self.usernameField, errorHint: error!)
            }
        }
        
        viewModel.passwordInputIsValid = { (isValid, error) in
            if (isValid) {
                self.setFormNormal(field: self.passwprdFIeld)
            } else {
                self.setFormError(field: self.passwprdFIeld, errorHint: error!)
            }
        }
    }
    
    private func promptGoogleAccountUI() {
        GIDSignIn.sharedInstance()?.signOut()
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.signIn()
    }
        
    private func promptFacebookAccountUI(){
        let loginManager = LoginManager()
        loginManager.logIn(permissions: [.publicProfile], viewController: self) { (loginResult) in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in! \(grantedPermissions) \(declinedPermissions) \(accessToken)")
                self.setIsLogin()
                self.navigateToHome()
            }
        }
    }
    
    private func setPasswordVisibilityOn() {
        passwordVisibilityOn = true
        passwprdFIeld.setSecureTextEntry(value: false)
        passwprdFIeld.setSideIcon(
            view: passwordVisibilityOnView
        )
    }
    
    private func setPasswordVisibilityOff() {
        passwordVisibilityOn = false
        passwprdFIeld.setSecureTextEntry(value: true)
        passwprdFIeld.setSideIcon(
            view: passwordVisibilityOffView
        )
    }
    
     private func setFormError(field: UIFormDefaultField, errorHint: String) {
        field.setState(state: UIFormDefaultField.FormState.error)
        field.setFieldHint(hint: errorHint)
        field.toggleHint(show: true)
    }
    
    private func setFormNormal(field: UIFormDefaultField, hint: String? = nil) {
        field.setState(state: UIFormDefaultField.FormState.normal)
        if (hint != nil) {
            field.setFieldHint(hint: hint!)
            field.toggleHint(show: true)
        } else {
            field.setFieldHint(hint: "")
            field.toggleHint(show: false)
        }
    }
    
    private func setContinueButtonEnabled() {
        loginButton.isEnabled = true
        loginButton?.style(style: ViewStyle.Button.main)
    }
    
    private func setContinueButtonDisabled() {
        loginButton.isEnabled = false
        loginButton?.style(style: ViewStyle.Button.mainDisabled)
    }
    
    private func navigateToHome() {
        Navigator.push(storyboard: Navigator.Screen.homeDashboard, viewController: self, animated: true)
     }
    
    private func setIsLogin(){
        UserDefaults.standard.set(true, forKey: "ALLREADY_REGISTER")
    }
}

extension LoginViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            setIsLogin()
            navigateToHome()
        } else {
            print("\(error.localizedDescription)")
        }
    }
}
