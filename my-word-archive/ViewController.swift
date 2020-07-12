//
//  ViewController.swift
//  my-word-archive
//
//  Created by HalitG on 5.07.2020.
//  Copyright © 2020 HalitG. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var learnView: UIView!
    @IBOutlet weak var learnViewTitle: UILabel!
    @IBOutlet weak var learnViewLeftButton: UIButton!
    @IBOutlet weak var learnViewRightButton: UIButton!
    
    var handle: AuthStateDidChangeListenerHandle?
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.setGradientBackground(colorTop: Colors.gradientStart, colorBottom: Colors.gradientEnd)
        learnView.layer.cornerRadius = 10
        //learnView.layer.opacity = 0.3
        learnView.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        
        learnViewLeftButton.layer.cornerRadius = learnViewLeftButton.frame.height/2
        learnViewLeftButton.layer.masksToBounds = true
        learnViewLeftButton.backgroundColor = Colors.bluebutton
        
        learnViewRightButton.layer.cornerRadius = learnViewRightButton.frame.height/2
        learnViewRightButton.layer.masksToBounds = true
        learnViewRightButton.backgroundColor = Colors.greenButton
        
        ref = Database.database().reference()
    }

    @IBAction func logoutButton(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
            CAAlert(successMessage: "Bye 👋👋👋").show()
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
            self.navigationController?.setViewControllers([viewController], animated: true)
        } catch let signoutError as NSError {
            CAAlert(errorMessage: signoutError.localizedDescription).show()
        }
    }
    
    
    @IBAction func learnViewRigtButtonClick(_ sender: Any) {
        if let user = Auth.auth().currentUser {
            self.ref.child("users").child(user.uid).setValue(["username": user.displayName!])
            CAAlert(successMessage: user.displayName! + " eklendi!!").show()
        }
    }
    
    @IBAction func learnViewLeftButtonClick(_ sender: Any) {
        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
          // Get user value
          let value = snapshot.value as? NSDictionary
          let username = value?["username"] as? String ?? ""

          CAAlert(successMessage: username + " alındı!!").show()
          }) { (error) in
            print(error.localizedDescription)
        }
    }
}

