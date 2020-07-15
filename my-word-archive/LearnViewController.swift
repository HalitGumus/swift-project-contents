//
//  LearnViewController.swift
//  my-word-archive
//
//  Created by HalitG on 13.07.2020.
//  Copyright © 2020 HalitG. All rights reserved.
//

import UIKit

class LearnViewController: UIViewController {
    
    @IBOutlet weak var learnView: UIView!
    @IBOutlet weak var learnKey: UILabel!
    @IBOutlet weak var learnValue: UILabel!
    @IBOutlet weak var flipView: UIView!
    @IBOutlet weak var flipButton: UIButton!
    
    var learnCards = [
        LearnCard(id: "1", author: "Halit", key: "Some", value: "Biraz", description: "have some fun"),
        LearnCard(id: "2", author: "Halit", key: "Time", value: "Zaman", description: "time out")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.setGradientBackground(colorTop: Colors.gradientStart, colorBottom: Colors.gradientEnd)
        
        learnView.layer.cornerRadius = 10
        learnView.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        
        flipView.layer.cornerRadius = flipView.frame.height/2
        flipView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        learnKey.textColor = Colors.niceBlue
        
        learnValue.textColor = UIColor.white
        
        learnKey.text = learnCards.first?.key
        learnValue.text = learnCards.first?.value
    }
    
}

