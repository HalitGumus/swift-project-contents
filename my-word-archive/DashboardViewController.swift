//
//  DashboardViewController.swift
//  My Word Archive
//
//  Created by HalitGUMUS on 31.08.2019.
//  Copyright © 2019 HalitGUMUS. All rights reserved.
//

import UIKit
import Firebase
import NVActivityIndicatorView

class DashboardViewController: CAViewController, NVActivityIndicatorViewable  {
    
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var termsAndPrivacyLabel: UILabel!
    @IBOutlet weak var phoneLoginButton: UIButton!
    @IBOutlet weak var facebookLoginButton: UIButton!
    @IBOutlet weak var guestButton: UIButton!
    
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            
            if let user = Auth.auth().currentUser {
                self.stopAnimating()
                
                UserService.observeUserProfile(user.uid) { userProfile in
                    UserService.currentUserProfile = userProfile
                }
                
                print("giriş yapıldı")
                CAAlert(successMessage:" Welcome 👋👋👋").show()
                let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! MainViewController
                self.navigationController?.setViewControllers([viewController], animated: true)
            }else{
                UserService.currentUserProfile = nil
                print("kullanıcı bulunamadı")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
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
    
    @IBAction func guestButton(_ sender: Any) {
        self.startAnimating()
        Auth.auth().signInAnonymously() { (authResult, error) in
            if let error = error {
                CAAlert(errorMessage: error.localizedDescription).show()
                self.stopAnimating()
                return
            }
            
            guard let user = authResult?.user else { return }
            let isAnonymous = user.isAnonymous  // true
            let uid = user.uid
            let userName = "Guest-" + uid.suffix(5)
            
            let image = #imageLiteral(resourceName: "profileImage")
            UserService.uploadProfileImage(image) { url in
                
                if url != nil {
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = userName
                    changeRequest?.photoURL = url
                    
                    changeRequest?.commitChanges { error in
                        if error == nil {
                            print("User display name changed!")
                            
                            UserService.saveProfile(userName: userName, profileImageUrl: url!) { success in
                                if success {
                                    CAAlert(successMessage: "Profil kaydedildi!").show()
                                }
                            }
                            
                        }
                    }
                    
                } else {
                    // Error unable to upload profile image
                    self.stopAnimating()
                    CAAlert(errorMessage: "Profil resmi yüklenemedi!").show()
                }
            }
        }
    }
    
    override func setupUI() {
        appNameLabel.textColor = Colors.titleColor
        aboutLabel.textColor = Colors.titleColor
        termsAndPrivacyLabel.textColor = Colors.subTitleColor
        guestButton.titleLabel?.textColor = Colors.titleColor
    }
}
