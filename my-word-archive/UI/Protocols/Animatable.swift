//
//  Animatable.swift
//  my-word-archive
//
//  Created by HalitGUMUS on 22.09.2019.
//  Copyright © 2019 HalitGUMUS. All rights reserved.
//


import UIKit

/// Conform to `Animatable` protocol to animate views.
public protocol Animatable: AnyObject {}

// MARK: - Default implementation for UIView.
public extension Animatable where Self: UIView {
    
    /// Fade in view.
    ///
    /// - Parameters:
    ///   - duration: animation duration in seconds _default value is 1.0 second_.
    ///   - delay: animation delay in seconds _default value is 0.0 second_.
    ///   - completion: optional completion handler to run with animation finishes _default value is nil_.
    public func fadeIn(withDuration duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: delay, options: [], animations: { [unowned self] in
            self.alpha = 1.0
            }, completion: completion)
    }
    
    /// Fade out view.
    ///
    /// - Parameters:
    ///   - duration: animation duration in seconds _default value is 1.0 second_.
    ///   - delay: animation delay in seconds _default value is 0.0 second_.
    ///   - completion: optional completion handler to run with animation finishes _default value is nil_.
    public func fadeOut(withDuration duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: delay, options: [], animations: { [unowned self] in
            self.alpha = 0.0
            }, completion: completion)
    }
    
    /// Pop in view.
    ///
    /// - Parameters:
    ///   - duration: animation duration in seconds _default value is 0.25 second_.
    ///   - delay: animation delay in seconds _default value is 0.0 second_.
    ///   - completion: optional completion handler to run with animation finishes _default value is nil_.
    public func popIn(withDuration duration: TimeInterval = 0.25, delay: TimeInterval = 0.0, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: delay, options: [], animations: { [unowned self] in
            self.transform = .init(scaleX: 0.95, y: 0.95)
            }, completion: completion)
    }
    
    /// Pop out view.
    ///
    /// - Parameters:
    ///   - duration: animation duration in seconds _default value is 0.25 second_.
    ///   - delay: animation delay in seconds _default value is 0.0 second_.
    ///   - completion: optional completion handler to run with animation finishes _default value is nil_.
    public func popOut(withDuration duration: TimeInterval = 0.25, delay: TimeInterval = 0.0, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: delay, options: [], animations: { [unowned self] in
            self.transform = .identity
            }, completion: completion)
    }
    
    /// Shake view.
    ///
    /// - Parameters:
    ///   - duration: animation duration in seconds _default value is 1.0 second_.
    ///   - delay: animation delay in seconds _default value is 0.0 second_.
    ///   - completion: optional completion handler to run with animation finishes _default value is nil_.
    public func shake(withDuration duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: (() -> Void)? = nil) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [unowned self] in
            CATransaction.begin()
            let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
            CATransaction.setCompletionBlock(completion)
            animation.duration = duration
            animation.values = [-15.0, 15.0, -12.0, 12.0, -8.0, 8.0, -3.0, 3.0, 0.0]
            self.layer.add(animation, forKey: "shake")
            CATransaction.commit()
        }
    }
    
}
