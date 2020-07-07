//  my-word-archive
//
//  Created by HalitGUMUS on 14.09.2019.
//  Copyright © 2019 HalitGUMUS. All rights reserved.
//


// https://github.com/Kofktu/Gradientable

import UIKit

extension UIView {

	static var isClassInit: Bool = false
	static let classInit: Void = {
		guard !UIView.isClassInit else {
			return
		}

		UIView.isClassInit = true
		let originalSelector = #selector(layoutSubviews)
		let swizzledSelector = #selector(swizzled_layoutSubviews)
		guard let originalMethod = class_getInstanceMethod(UIView.self, originalSelector),
			let swizzledMethod = class_getInstanceMethod(UIView.self, swizzledSelector) else {
				return
		}
		method_exchangeImplementations(originalMethod, swizzledMethod)
	}()

	@objc
	func swizzled_layoutSubviews() {
		swizzled_layoutSubviews()
		gradientLayer?.frame = bounds
	}

}
