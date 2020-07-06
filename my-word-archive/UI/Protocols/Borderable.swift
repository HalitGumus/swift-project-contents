//
//   Borderable.swift
//  TheDatingApp
//
//  Created by HalitGUMUS on 22.09.2019.
//  Copyright © 2019 HalitGUMUS. All rights reserved.
//


import UIKit

/// Conform to `Borderable` protocol to set border reloated properties for views.
public protocol Borderable: AnyObject {}

// MARK: - Default implementation for UIView.
public extension Borderable where Self: UIView {
    
    /// View corner radius.
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            clipsToBounds = true
            layer.cornerRadius = newValue
        }
    }
    
    /// View border width.
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    /// View border color.
    var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    /// Set border properties for a view.
    ///
    /// - Parameters:
    ///   - width: View border width _default value is nil_.
    ///   - color: View border color _default value is nil_.
    ///   - radius: View corner radius _default value is nil_.
    func setBorder(width: CGFloat? = nil, color: UIColor? = nil, radius: CGFloat? = nil) {
        if let borderWidth = width {
            self.borderWidth = borderWidth
        }
        
        self.borderColor = color
        
        if let cornerRadius = radius {
            self.cornerRadius = cornerRadius
        }
    }
    
}
