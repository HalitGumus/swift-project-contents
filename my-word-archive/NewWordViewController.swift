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


class NewWordViewController: UIViewController, UITextFieldDelegate, NVActivityIndicatorViewable {
    
    
    @IBOutlet weak var keyTextField: MFTextField!
    @IBOutlet weak var valueTextField: MFTextField!
    @IBOutlet weak var descTextField: MFTextField!
    @IBOutlet weak var addButton: CAButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.setGradientBackground(colorTop: Colors.gradientStart, colorBottom: Colors.gradientEnd)
        
        keyTextField.animatesPlaceholder = true
        keyTextField.tintColor = UIColor(red: 232 / 255.0, green: 65 / 255.0, blue: 124 / 255.0, alpha: 1.0)
        keyTextField.textColor = UIColor.mf_veryDarkGray()
        keyTextField.delegate = self
        
        valueTextField.animatesPlaceholder = true
        valueTextField.tintColor = UIColor(red: 232 / 255.0, green: 65 / 255.0, blue: 124 / 255.0, alpha: 1.0)
        valueTextField.textColor = UIColor.mf_veryDarkGray()
        valueTextField.delegate = self
        
        descTextField.animatesPlaceholder = true
        descTextField.tintColor = UIColor(red: 232 / 255.0, green: 65 / 255.0, blue: 124 / 255.0, alpha: 1.0)
        descTextField.textColor = UIColor.mf_veryDarkGray()
        descTextField.delegate = self
    }
    
    @IBAction func addButton(_ sender: Any) {
        
        guard let userProfile = UserService.currentUserProfile else { return }
        
        let postRef = Database.database().reference().child("words").childByAutoId()
        
        let postObject = [
            "author": [
                "uid": userProfile.uid,
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
