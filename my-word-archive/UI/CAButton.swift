//
//  CAButton.swift
//  my-word-archive
//
//  Created by HalitGUMUS on 22.09.2019.
//  Copyright © 2019 HalitGUMUS. All rights reserved.
//

import UIKit

/// CAButton `UIButton`.
open class CAButton: UIButton,Borderable {

    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.backgroundColor = Colors.buttonBackground
        self.setTitleColor(Colors.buttonText, for: .normal)
        self.titleLabel?.font =  UIFont(name: "ProximaNovaSoft-Semibold", size: 22)
        
        self.layer.cornerRadius = self.frame.height/2
        self.layer.borderWidth = 1
        self.layer.borderColor = Colors.borderColor.cgColor
        self.layer.masksToBounds = true
    }
    
}
