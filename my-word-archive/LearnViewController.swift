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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.setGradientBackground(colorTop: Colors.gradientStart, colorBottom: Colors.gradientEnd)
        
        learnView.layer.cornerRadius = 10
        learnView.backgroundColor = UIColor.white.withAlphaComponent(0.3)
    }
    
}

