//
//  CAPillButton.swift
//  my-word-archive
//
//  Created by HalitGUMUS on 22.09.2019.
//  Copyright © 2019 HalitGUMUS. All rights reserved.
//

import UIKit

/// Pill `Button`.
open class CAPillButton: CAButton {
    
    /// The bounds rectangle, which describes the view’s location and size in its own coordinate system.
    override open var bounds: CGRect {
        didSet {
            cornerRadius = bounds.height / 2
        }
    }
    
}
