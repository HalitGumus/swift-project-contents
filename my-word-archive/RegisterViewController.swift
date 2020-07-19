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
import NVActivityIndicatorView
import Kingfisher

class RegisterViewController: CAViewController, UITextFieldDelegate, NVActivityIndicatorViewable {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userNameTextField: MFTextField!
    @IBOutlet weak var emailTextField: MFTextField!
    @IBOutlet weak var passwordTextField: MFTextField!
    @IBOutlet weak var repeadPassword: MFTextField!
    @IBOutlet weak var loginButton: CAButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileImageButton: UIButton!
    
    var imagePicker: UIImagePickerController!
    var isUpdateUser = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let userProfile = UserService.currentUserProfile {
            setUserProfile(userProfile)
            
            let firebaseAuth = Auth.auth()
            guard let user = firebaseAuth.currentUser else { return }
            if user.isAnonymous {
                loginButton.setTitle("Create account", for: .normal)
            }
            loginButton.setTitle("Update profile", for: .normal)
        }
    }
    
    @objc func openImagePicker(_ sender:Any){
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func registerButton(_ sender: Any) {
        if isUpdateUser {
            
            self.updateAnonymousUser(userName:userNameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!)
            return
        }
        signUpWithFirebase(userName:userNameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!)
    }
    
    func updateAnonymousUser(userName:String, email:String, password:String){
        self.startAnimating()
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        
        Auth.auth().currentUser?.link(with: credential) { (authResult, error) in
          /*let prevUser = Auth.auth().currentUser
          Auth.auth().signIn(with: credential) { (authResult, error) in
          
          }*/
            if let error = error {
                CAAlert(errorMessage: error.localizedDescription).show()
                self.stopAnimating()
                return
            }
            
            self.updateProfile()
        }
    }
    
    func signUpWithFirebase(userName:String, email:String, password:String){
        
        guard let image = profileImageView.image else { return }
        self.startAnimating()
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            
            if let error = error {
                CAAlert(errorMessage: error.localizedDescription).show()
                self.stopAnimating()
                return
            }
            
            self.updateProfile()
        }
    }

    func updateProfile(){
        guard let image = profileImageView.image else { return }
        guard let userName = userNameTextField.text else { return }
        
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
                                self.stopAnimating()
                                CAAlert(successMessage: "Kayıt başarılı").show()
                                
                                let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! MainViewController
                                self.navigationController?.setViewControllers([viewController], animated: true)
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
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.userNameTextField {
            validateUserName()
        }
        if textField == self.passwordTextField {
            validatePassword()
        }
        return true
    }
    
    func validateUserName(){
        if userNameTextField.text?.count ?? 0 < 4 {
            userNameTextField.setError(NSError(domain: "", code: 100, userInfo: [NSLocalizedDescriptionKey:"Minumum 5 karakter girilmeli"]), animated: true)
            return
        }
        userNameTextField.setError(nil, animated: true)
    }
    
    func validatePassword(){
        if passwordTextField.text?.count ?? 0 < 5 {
            passwordTextField.setError(NSError(domain: "", code: 100, userInfo: [NSLocalizedDescriptionKey:"Minumum 6 karakter girilmeli"]), animated: true)
            return
        }
        passwordTextField.setError(nil, animated: true)
    }
    
    override func setupUI() {
        userNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        repeadPassword.delegate = self
        
        profileImageButton.setTitleColor(Colors.subTitleColor, for: .normal)
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        profileImageView.isUserInteractionEnabled = true
        profileImageView.layer.cornerRadius = profileImageView.bounds.height/2
        profileImageView.clipsToBounds = true
        profileImageView.addGestureRecognizer(imageTap)
        profileImageButton.addTarget(self, action: #selector(openImagePicker), for: .touchUpInside)
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.modalPresentationStyle = .fullScreen
        
        titleLabel.textColor = Colors.titleColor
    }
    
    func setUserProfile(_ userProfile: UserProfile){
        emailTextField.text = userProfile.email
        userNameTextField.text = userProfile.userName
        
        let url = URL(string: userProfile.photoUrl.absoluteString)
        profileImageView.kf.setImage(with: url)
    }
}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.profileImageView.image = pickedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}
