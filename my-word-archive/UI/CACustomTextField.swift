//
//  CATextField.swift
//  my-word-archive
//
//  Created by HalitG on 18.07.2020.
//  Copyright © 2020 HalitG. All rights reserved.
//

import UIKit
import MaterialTextField

/// CACustomTextField `MFTextField `.
open class CACustomTextField: MFTextField {

    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.animatesPlaceholder = true
        self.tintColor = Colors.mainBlueColor
        self.textColor = Colors.titleColor
        self.defaultPlaceholderColor = Colors.subTitleColor
        self.errorColor = Colors.errorColor
    }
    
}
