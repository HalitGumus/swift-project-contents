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
    
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.setGradientBackground(colorTop: Colors.gradientStart, colorBottom: Colors.gradientEnd)

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
}

