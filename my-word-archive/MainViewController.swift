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

class MainViewController: CAViewController {
    
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var learnView: UIView!
    @IBOutlet weak var learnViewTitle: UILabel!
    @IBOutlet weak var learnViewLeftButton: UIButton!
    @IBOutlet weak var learnViewRightButton: UIButton!
    
    @IBOutlet weak var newWordView: UIView!
    @IBOutlet weak var newWordTitle: UILabel!
    @IBOutlet weak var newWordButton: UIButton!
    
    
    
    var handle: AuthStateDidChangeListenerHandle?
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    @IBAction func profileUpdateButton(_ sender: Any) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController
        vc?.isUpdateUser = true
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    
    @IBAction func learnViewRigtButtonClick(_ sender: Any) {
//        if let user = Auth.auth().currentUser {
//            self.ref.child("users").child(user.uid).setValue(["username": user.displayName!])
//            CAAlert(successMessage: user.displayName! + " eklendi!!").show()
//        }
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LearnViewController") as? LearnViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func learnViewLeftButtonClick(_ sender: Any) {
        /*
        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
          // Get user value
          let value = snapshot.value as? NSDictionary
          let username = value?["userName"] as? String ?? ""

          CAAlert(successMessage: username + " alındı!!").show()
          }) { (error) in
            print(error.localizedDescription)
        }*/
        
    }

    
    @IBAction func newWordButton(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "NewWordViewController") as? NewWordViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    override func setupUI() {
        
        learnView.layer.cornerRadius = 10
        learnView.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        
        learnViewLeftButton.layer.cornerRadius = learnViewLeftButton.frame.height/2
        learnViewLeftButton.layer.masksToBounds = true
        learnViewLeftButton.backgroundColor = Colors.bluebutton
        
        learnViewRightButton.layer.cornerRadius = learnViewRightButton.frame.height/2
        learnViewRightButton.layer.masksToBounds = true
        learnViewRightButton.backgroundColor = Colors.greenButton
        
        newWordView.layer.cornerRadius = 10
        newWordView.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        
        newWordButton.layer.cornerRadius = learnViewRightButton.frame.height/2
        newWordButton.layer.masksToBounds = true
        newWordButton.backgroundColor = Colors.greenButton
    }
}

