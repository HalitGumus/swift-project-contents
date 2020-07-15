//
//  LearnCard.swift
//  my-word-archive
//
//  Created by HalitG on 15.07.2020.
//  Copyright © 2020 HalitG. All rights reserved.
//

class LearnCard {
    var id: String
    var author: UserProfile
    var key: String
    var value: String
    var description: String
    
    init(id:String, author:UserProfile, key:String, value:String, description:String) {
        self.id = id
        self.author = author
        self.key = key
        self.value = value
        self.description = description
    }
}
