//
//  ViewController.swift
//  my-word-archive
//
//  Created by HalitG on 5.07.2020.
//  Copyright © 2020 HalitG. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var headerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.setGradientBackground(colorTop: Colors.gradientStart, colorBottom: Colors.gradientEnd)
        
        
        signInWithFirebase()
        
    }
    
    func signUpWithFirebase(){
        Auth.auth().createUser(withEmail: "halitgumus47@gmail.com", password: "p12346") { authResult, error in
            
            if let error = error {
                print(error)
                return
            }
            
            print("Başarılı bir şekilde kayıt yaptınız")
        }
    }
    
    func signInWithFirebase(){
        Auth.auth().signIn(withEmail: "halitgumus47@gmail.com", password: "p12346") { [weak self] authResult, error in
            guard self != nil else { return }
            
            if let error = error {
                print(error)
                return
            }
            
            print("Başarılı bir şekilde giriş yaptınız")
        }
    }
    
}

