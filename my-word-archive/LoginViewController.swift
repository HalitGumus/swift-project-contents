//
//  LoginViewController.swift
//  My Word Archive
//
//  Created by HalitGUMUS on 30.08.2019.
//  Copyright © 2019 HalitGUMUS. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import MaterialTextField
import Firebase

class LoginViewController: CAViewController, UITextFieldDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emailTextField: MFTextField!
    @IBOutlet weak var passwordTextField: MFTextField!
    @IBOutlet weak var loginButton: CAButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.animatesPlaceholder = true
        emailTextField.tintColor = UIColor(red: 232 / 255.0, green: 65 / 255.0, blue: 124 / 255.0, alpha: 1.0)
        emailTextField.textColor = UIColor.mf_veryDarkGray()
        emailTextField.delegate = self
        
        passwordTextField.animatesPlaceholder = true
        passwordTextField.tintColor = UIColor(red: 232 / 255.0, green: 65 / 255.0, blue: 124 / 255.0, alpha: 1.0)
        passwordTextField.textColor = UIColor.mf_veryDarkGray()
        passwordTextField.delegate = self
        
    }
    
    @IBAction func loginButton(_ sender: Any) {
        signInWithFirebase(email: emailTextField.text!, password: passwordTextField.text!)
    }
    
    func signInWithFirebase(email:String, password:String){
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard self != nil else { return }
            
            if let error = error {
                CAAlert(errorMessage: error.localizedDescription).show()
                return
            }
            
            self?.loginSuccess()
        }
    }
    
    func loginSuccess(){
        if let user = Auth.auth().currentUser {
                       let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                       self.navigationController?.setViewControllers([viewController], animated: true)
            CAAlert(successMessage: user.displayName! + " Welcome 👋👋👋").show()
        }
    }
    
}
