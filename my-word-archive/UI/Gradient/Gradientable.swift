//  my-word-archive
//
//  Created by HalitGUMUS on 14.09.2019.
//  Copyright © 2019 HalitGUMUS. All rights reserved.
//


// https://github.com/Kofktu/Gradientable

import UIKit

protocol GradientableAppliable {

	func apply(layer: CAGradientLayer?)

}

/// Conform to `Gradientable` protocol in `UIView` to set gradient properties.
public protocol Gradientable {

	/// Set gradient with `GradientableOptions`.
	///
	/// - Parameter options: `GradientableOptions`.
	func setGradient(withOptions options: GradientableOptions)

	/// Set gradient with `GradientableAnimation`.
	///
	/// - Parameter animation: `GradientableAnimation`.
	func setGradient(withAnimation animation: GradientableAnimation)

}

// MARK: - Default implementation for UIView.
public extension Gradientable where Self: UIView {

	public func setGradient(withOptions options: GradientableOptions) {
		if gradientLayer == nil { setupGradientable() }
		options.apply(layer: gradientLayer)
	}

	public func setGradient(withAnimation animation: GradientableAnimation) {
		if gradientLayer == nil { setupGradientable() }
		animation.apply(layer: gradientLayer)
	}

	private func setupGradientable() {
		UIView.classInit
		gradientLayer = CAGradientLayer()
		gradientLayer?.frame = bounds
		layer.insertSublayer(gradientLayer!, at: 0)
	}

}

extension UIView {

	struct AssociatedKeys {
		static var gradientLayer = "gradientLayer"
	}

	var gradientLayer: CAGradientLayer? {
		get {
			return objc_getAssociatedObject(self, &AssociatedKeys.gradientLayer) as? CAGradientLayer
		}
		set {
			objc_setAssociatedObject(self, &AssociatedKeys.gradientLayer, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}

}
