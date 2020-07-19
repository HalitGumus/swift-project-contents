//
//  NewWordViewController.swift
//  my-word-archive
//
//  Created by HalitG on 15.07.2020.
//  Copyright © 2020 HalitG. All rights reserved.
//

import UIKit
import MaterialTextField
import Firebase
import NVActivityIndicatorView


class NewWordViewController: CAViewController, UITextFieldDelegate, NVActivityIndicatorViewable {
    
    
    @IBOutlet weak var keyTextField: CACustomTextField!
    @IBOutlet weak var valueTextField: CACustomTextField!
    @IBOutlet weak var descTextField: CACustomTextField!
    @IBOutlet weak var addButton: CAButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        keyTextField.delegate = self
        valueTextField.delegate = self
        descTextField.delegate = self
    }
    
    @IBAction func addButton(_ sender: Any) {
        
        guard let userProfile = UserService.currentUserProfile else { return }
        
        let postRef = Database.database().reference().child("words").childByAutoId()
        
        let postObject = [
            "author": [
                "uid": userProfile.uid,
                "email": userProfile.email,
                "userName": userProfile.userName,
                "photoURL": userProfile.photoUrl.absoluteString
            ],
            "key": keyTextField.text!,
            "value": valueTextField.text!,
            "desc": descTextField.text!
        ] as [String:Any]
        
        self.startAnimating()
        postRef.setValue(postObject, withCompletionBlock: { error, ref in
            self.stopAnimating()
            if error == nil {
                CAAlert(successMessage: "Kelime eklendi!").show()
            }else{
                CAAlert(errorMessage: "İşlem başarısız. Daha sonra tekrar dene!").show()
            }
        })
    }
    
}
