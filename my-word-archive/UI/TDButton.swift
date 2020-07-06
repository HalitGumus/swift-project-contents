//
//  TDButton.swift
//  TheDatingApp
//
//  Created by HalitGUMUS on 22.09.2019.
//  Copyright © 2019 HalitGUMUS. All rights reserved.
//

import UIKit

/// TDButton `UIButton`.
open class TDButton: UIButton,Borderable {

    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.backgroundColor = UIColor.clear
        self.titleLabel?.textColor = Colors.defaultButton
        self.titleLabel?.font =  UIFont(name: "ProximaNovaSoft-Semibold", size: 22)
    }
    
}
