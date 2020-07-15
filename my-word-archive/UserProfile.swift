//
//  UserProfile.swift
//  my-word-archive
//
//  Created by HalitG on 15.07.2020.
//  Copyright © 2020 HalitG. All rights reserved.
//

import Foundation

class UserProfile {
    var uid: String
    var userName: String
    var photoUrl: URL
    
    init(uid: String, userName: String, photoUrl: URL) {
        self.uid = uid
        self.userName = userName
        self.photoUrl = photoUrl
    }
}
