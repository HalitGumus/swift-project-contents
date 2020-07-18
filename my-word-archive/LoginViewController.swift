//
//  LoginViewController.swift
//  My Word Archive
//
//  Created by HalitGUMUS on 30.08.2019.
//  Copyright © 2019 HalitGUMUS. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import Firebase

class LoginViewController: CAViewController, UITextFieldDelegate, NVActivityIndicatorViewable {
    
    @IBOutlet weak var emailTextField: CACustomTextField!
    @IBOutlet weak var passwordTextField: CACustomTextField!
    @IBOutlet weak var loginButton: CAButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func loginButton(_ sender: Any) {
        signInWithFirebase(email: emailTextField.text!, password: passwordTextField.text!)
    }
    
    func signInWithFirebase(email:String, password:String){
        self.startAnimating()
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard self != nil else { return }
            
            if let error = error {
                self?.loginError(errorMessage: error.localizedDescription)
                return
            }
            
            self?.loginSuccess()
        }
    }
    
    func loginSuccess(){
        self.stopAnimating()
        if let user = Auth.auth().currentUser {
            
            UserService.observeUserProfile(user.uid) { userProfile in
                UserService.currentUserProfile = userProfile
            }
            
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! MainViewController
            self.navigationController?.setViewControllers([viewController], animated: true)
            CAAlert(successMessage: user.displayName! + " Welcome 👋👋👋").show()
        }
    }
    
    func loginError(errorMessage: String){
        self.stopAnimating()
        CAAlert(errorMessage: errorMessage).show()
        return
    }
    
    override func setupUI() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
}
