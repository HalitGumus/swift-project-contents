//
//  GradientableOptions.swift
//  TheDatingApp
//
//  Created by HalitGUMUS on 14.09.2019.
//  Copyright © 2019 HalitGUMUS. All rights reserved.
//


import UIKit

/// `GradientableOptions` defines options to be used with the `Gradientable` protocol.
public struct GradientableOptions: GradientableAppliable {
    
    /// Gradientable direction.
    public enum Direction {
        
        /// Top.
        case top
        
        /// Bottom.
        case bottom
        
        /// Left.
        case left
        
        /// Right.
        case right
        
        /// Top left to bottom right.
        case topLeftToBottomRight
        
        /// Top right to bottom left.
        case topRightToBottomLeft
        
        /// Bottom left to top right.
        case bottomLeftToTopRight
        
        /// Bottom right to top left.
        case bottomRightToTopLeft
        
        /// Custom from start to end points.
        case custom(startPoint: CGPoint, endPoint: CGPoint)
        
    }
    
    var colors: [UIColor]?
    var locations: [NSNumber]?
    var direction: Direction?
    
    /// Create a new `GradientableOptions`.
    ///
    /// - Parameters:
    ///   - colors: Optional gradient color. _default value is nil_
    ///   - locations: Optional gradient locations. _default value is nil_
    ///   - direction: Optional gradient direction. _default value is nil_
    public init(colors: [UIColor]? = nil, locations: [NSNumber]? = nil, direction: Direction? = nil) {
        self.colors = colors
        self.locations = locations
        self.direction = direction
    }
    
    func apply(layer: CAGradientLayer?) {
        layer?.colors = colors?.compactMap { $0.cgColor } ?? layer?.colors
        layer?.locations = locations ?? layer?.locations
        applyDirection(layer: layer)
    }
    
    private func applyDirection(layer: CAGradientLayer?) {
        guard let direction = direction else { return }
        
        switch direction {
        case .top:
            layer?.startPoint = CGPoint(x: 0.5, y: 1.0)
            layer?.endPoint = CGPoint(x: 0.5, y: 0.0)
        case .bottom:
            layer?.startPoint = CGPoint(x: 0.5, y: 0.0)
            layer?.endPoint = CGPoint(x: 0.5, y: 1.0)
        case .left:
            layer?.startPoint = CGPoint(x: 1.0, y: 0.5)
            layer?.endPoint = CGPoint(x: 0.0, y: 0.5)
        case .right:
            layer?.startPoint = CGPoint(x: 0.0, y: 0.5)
            layer?.endPoint = CGPoint(x: 1.0, y: 0.5)
        case .topLeftToBottomRight:
            layer?.startPoint = CGPoint(x: 0.0, y: 0.0)
            layer?.endPoint = CGPoint(x: 1.0, y: 1.0)
        case .topRightToBottomLeft:
            layer?.startPoint = CGPoint(x: 1.0, y: 0.0)
            layer?.endPoint = CGPoint(x: 0.0, y: 1.0)
        case .bottomLeftToTopRight:
            layer?.startPoint = CGPoint(x: 0.0, y: 1.0)
            layer?.endPoint = CGPoint(x: 1.0, y: 0.0)
        case .bottomRightToTopLeft:
            layer?.startPoint = CGPoint(x: 1.0, y: 1.0)
            layer?.endPoint = CGPoint(x: 0.0, y: 0.0)
        case .custom(let startPoint, let endPoint):
            layer?.startPoint = startPoint
            layer?.endPoint = endPoint
        }
    }
    
}
