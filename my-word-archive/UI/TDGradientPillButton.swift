//
//  TDGradientPillButton.swift
//  TheDatingApp
//
//  Created by HalitGUMUS on 22.09.2019.
//  Copyright © 2019 HalitGUMUS. All rights reserved.
//

import UIKit

/// TDButton `UIButton`.
open class TDGradientPillButton: PillButton {
    
    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.backgroundColor = UIColor.clear
        self.titleLabel?.textColor = Colors.defaultButton
        self.titleLabel?.font =  UIFont(name: "ProximaNovaSoft-Semibold", size: 22)
        
        self.setGradientBackgroundLeftToRight(colorLeft: Colors.gradientStart, colorRight: Colors.gradientEnd)
        self.setTitleColor(Colors.gradientPillButtonTitle, for: .normal)
        self.layer.masksToBounds = true

    }
    
}
