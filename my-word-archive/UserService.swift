//
//  UserService.swift
//  my-word-archive
//
//  Created by HalitG on 15.07.2020.
//  Copyright © 2020 HalitG. All rights reserved.
//

import Foundation
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
    
}
