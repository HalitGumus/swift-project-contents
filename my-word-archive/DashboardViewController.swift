//
//  DashboardViewController.swift
//  My Word Archive
//
//  Created by HalitGUMUS on 31.08.2019.
//  Copyright © 2019 HalitGUMUS. All rights reserved.
//

import UIKit
import Firebase

class DashboardViewController: CAViewController {
    
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var termsAndPrivacyLabel: UILabel!
    @IBOutlet weak var phoneLoginButton: UIButton!
    @IBOutlet weak var facebookLoginButton: UIButton!
    @IBOutlet weak var contactLabel: UILabel!
    
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.setGradientBackground(colorTop: Colors.gradientStart, colorBottom: Colors.gradientEnd)
        
        
        phoneLoginButton.setGradientBackgroundLeftToRight(colorLeft: Colors.gradientStart, colorRight: Colors.gradientEnd)
        phoneLoginButton.layer.cornerRadius = phoneLoginButton.frame.height/2
        phoneLoginButton.layer.borderWidth = 1
        phoneLoginButton.layer.borderColor = UIColor.white.cgColor
        phoneLoginButton.layer.masksToBounds = true
        
        facebookLoginButton.setGradientBackgroundLeftToRight(colorLeft: Colors.gradientStart, colorRight: Colors.gradientEnd)
        facebookLoginButton.layer.cornerRadius = phoneLoginButton.frame.height/2
        facebookLoginButton.layer.borderWidth = 1
        facebookLoginButton.layer.borderColor = UIColor.white.cgColor
        facebookLoginButton.layer.masksToBounds = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
          
            if let user = Auth.auth().currentUser {
                print("giriş yapıldı")
                CAAlert(successMessage: user.displayName! + " Welcome 👋👋👋").show()
                let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! MainViewController
                self.navigationController?.setViewControllers([viewController], animated: true)
            }else{
                print("kullanıcı bulunamadı")
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    @IBAction func loginButton(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func registerButton(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
