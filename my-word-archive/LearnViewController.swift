//
//  LearnViewController.swift
//  my-word-archive
//
//  Created by HalitG on 13.07.2020.
//  Copyright © 2020 HalitG. All rights reserved.
//

import UIKit
import Firebase
import NVActivityIndicatorView

class LearnViewController: CAViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var learnView: UIView!
    @IBOutlet weak var learnKey: UILabel!
    @IBOutlet weak var learnValue: UILabel!
    @IBOutlet weak var flipView: UIView!
    @IBOutlet weak var flipButton: UIButton!
    
    var learnCards = [LearnCard]()
    var cardType = true
    var cardNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        learnView.layer.cornerRadius = 10
        learnView.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        
        flipView.layer.cornerRadius = flipView.frame.height/2
        flipView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        learnKey.textColor = Colors.niceBlue
        
        learnValue.textColor = UIColor.white
        
        observeCards()
    }
    
    func observeCards(){
        self.startAnimating()
        
        let cardsRef = Database.database().reference().child("words")
        
        cardsRef.observe(.value, with: { snapshot in
            
            var tempCards = [LearnCard]()
            
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                    let dict = childSnapshot.value as? [String:Any],
                    let author = dict["author"] as? [String: Any],
                    let uid = author["uid"] as? String,
                    let email = author["email"] as? String,
                    let userName = author["userName"] as? String,
                    let photoUrl = author["photoURL"] as? String,
                    let url = URL(string: photoUrl),
                    let key = dict["key"] as? String,
                    let value = dict["value"] as? String,
                    let desc = dict["desc"] as? String {
                    
                    let userProfile = UserProfile(uid: uid, email:email, userName: userName, photoUrl: url)
                    let card = LearnCard(id: childSnapshot.key, author: userProfile, key: key, value: value, description: desc)
                    tempCards.append(card)
                }
            }
            self.stopAnimating()
            self.learnCards = tempCards
            self.updateCard()
        })
    }
    
    @IBAction func flipButton(_ sender: Any) {
        cardType = !cardType
        updateCard()
    }
    
    @IBAction func nextButton(_ sender: Any) {
        if cardNumber < learnCards.count - 1 {
            cardNumber = cardNumber + 1
            updateCard()
        }
    }
    
    func updateCard(){
        if learnCards.count > 0 {
            self.learnKey.text = self.learnCards[cardNumber].key
            self.learnValue.text = cardType ? self.learnCards[cardNumber].value : self.learnCards[cardNumber].description
        }
    }
    
}

