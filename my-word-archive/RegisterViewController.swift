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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.setGradientBackground(colorTop: Colors.gradientStart, colorBottom: Colors.gradientEnd)
        
        userNameTextField.animatesPlaceholder = true
        userNameTextField.tintColor = UIColor(red: 232 / 255.0, green: 65 / 255.0, blue: 124 / 255.0, alpha: 1.0)
        userNameTextField.textColor = UIColor.mf_veryDarkGray()
        userNameTextField.delegate = self
        
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
        
        profileImageButton.titleLabel?.textColor = UIColor.mf_veryDarkGray()
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
    }
    
    @objc func openImagePicker(_ sender:Any){
        self.present(imagePicker, animated: true, completion: nil)
    }

    @IBAction func registerButton(_ sender: Any) {
        signUpWithFirebase(userName:userNameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!)
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
            
            self.uploadProfileImage(image) { url in
                
                if url != nil {
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = userName
                    changeRequest?.photoURL = url
                    
                    changeRequest?.commitChanges { error in
                        if error == nil {
                            print("User display name changed!")
                            
                            self.saveProfile(userName: userName, profileImageUrl: url!) { success in
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
       }
    
    func uploadProfileImage(_ image:UIImage, completion: @escaping ((_ url: URL?)->())){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let storageRef = Storage.storage().reference().child("user/\(uid)")
        
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        storageRef.putData(imageData, metadata: metaData) { metaData, error in
            if error == nil, metaData != nil {
                storageRef.downloadURL { (url, error) in
                    if let downloadURL = url {
                        completion(downloadURL)
                    } else {
                    completion(nil)
                    }
                }
            } else {
                completion(nil)
            }
            
        }
    }
    
    func saveProfile(userName:String, profileImageUrl: URL, completion: @escaping ((_ success: Bool)->())){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let databaseRef = Database.database().reference().child("users/profile/\(uid)")
        
        let userObject = [
            "userName": userName,
            "photoURL": profileImageUrl.absoluteString
        ] as [String: Any]
        
        UserService.currentUserProfile = UserProfile(uid: uid, userName: userName, photoUrl: profileImageUrl)
        
        databaseRef.setValue(userObject) { (error, ref) in
            completion(error == nil)
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
