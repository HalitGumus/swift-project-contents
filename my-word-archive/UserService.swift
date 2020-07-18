//
//  UserService.swift
//  my-word-archive
//
//  Created by HalitG on 15.07.2020.
//  Copyright © 2020 HalitG. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class UserService {
    
    static var currentUserProfile: UserProfile?
    
    static func observeUserProfile(_ uid:String, comletion: @escaping ((_ userProfile: UserProfile?)->())) {
        
        let userRef = Database.database().reference().child("users/profile/\(uid)")
        
        userRef.observe(.value, with: { (snapshot) in
         
            var userProfile: UserProfile?
            
            if let dict = snapshot.value as? [String:Any],
                let userName = dict["userName"] as? String,
                let photoUrl = dict["photoURL"] as? String,
                let url = URL(string: photoUrl) {
                userProfile = UserProfile(uid: snapshot.key, userName: userName, photoUrl: url)
            }
            comletion(userProfile)
        })
    }
    
    static func uploadProfileImage(_ image:UIImage, completion: @escaping ((_ url: URL?)->())){
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
    
    static func saveProfile(userName:String, profileImageUrl: URL, completion: @escaping ((_ success: Bool)->())){
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
}
