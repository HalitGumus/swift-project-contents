//
//  RegisterViewController.swift
//  My Word Archive
//
//  Created by HalitGUMUS on 31.08.2019.
//  Copyright © 2019 HalitGUMUS. All rights reserved.
//

import UIKit
import MaterialTextField
import Firebase

class RegisterViewController: CAViewController, UITextFieldDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emailTextField: MFTextField!
    @IBOutlet weak var passwordTextField: MFTextField!
    @IBOutlet weak var repeadPassword: MFTextField!
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
        
        repeadPassword.animatesPlaceholder = true
        repeadPassword.tintColor = UIColor(red: 232 / 255.0, green: 65 / 255.0, blue: 124 / 255.0, alpha: 1.0)
        repeadPassword.textColor = UIColor.mf_veryDarkGray()
        repeadPassword.delegate = self
        
    }

    @IBAction func registerButton(_ sender: Any) {
        signUpWithFirebase(email: emailTextField.text!, password: passwordTextField.text!)
    }
    
    func signUpWithFirebase(email:String, password:String){
           Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
               
               if let error = error {
                CAAlert(errorMessage: error.localizedDescription).show()
                   return
               }
               
               CAAlert(successMessage: "Kayıt başarılı").show()
               
              let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
               self.navigationController?.setViewControllers([viewController], animated: true)
           }
       }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if textField == self.userNameTextField {
//            validateUserName()
//        }
//        return true
//    }
//
//    func validateUserName(){
//        if userNameTextField.text?.count ?? 0 < 4 {
//            userNameTextField.setError(NSError(domain: "", code: 100, userInfo: [NSLocalizedDescriptionKey:"Minumum 5 karakter girilmeli"]), animated: true)
//            return
//        }
//        userNameTextField.setError(nil, animated: true)
//    }
}
