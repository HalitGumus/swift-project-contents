//  my-word-archive
//
//  Created by HalitGUMUS on 14.09.2019.
//  Copyright © 2019 HalitGUMUS. All rights reserved.
//


// https://github.com/Kofktu/Gradientable

import UIKit

/// `GradientableAnimation` defines animation options to be used with the `Gradientable` protocol.
public struct GradientableAnimation: GradientableAppliable {

	private struct Keys {
		static let keyPath = "colors"
		static let gradientableAnimation = "GradientableAnimation"
	}

	var from: [UIColor]?
	var to: [UIColor]
	var duration: TimeInterval

	/// Create a new `GradientableAnimation`.
	///
	/// - Parameters:
	///   - to: to colors array.
	///   - duration: animation duration. _default value is 0.25_
	///   - from: Optional from colors array _default value is nil_
	public init(to: [UIColor], duration: TimeInterval = 0.25, from: [UIColor]? = nil) {
		self.to = to
		self.from = from
		self.duration = duration
	}

	func apply(layer: CAGradientLayer?) {
		layer?.removeAnimation(forKey: Keys.gradientableAnimation)

		let animation = CABasicAnimation(keyPath: Keys.keyPath)
		let colorSet = to.map { $0.cgColor }
		let delegate = GradientableDelegate.shared
		delegate.onAnimationFinished = {
			layer?.colors = colorSet
		}
		animation.delegate = delegate
		animation.duration = duration
		animation.fromValue = from?.compactMap { $0.cgColor } ?? layer?.colors
		animation.toValue = colorSet
		animation.fillMode = .forwards
		animation.isRemovedOnCompletion = false
		layer?.add(animation, forKey: Keys.gradientableAnimation)
	}

}

final class GradientableDelegate: NSObject, CAAnimationDelegate {

	static let shared = GradientableDelegate()
	var onAnimationFinished: (() -> Void)?

	func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
		if flag {
			onAnimationFinished?()
		}
	}
}
