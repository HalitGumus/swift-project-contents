//
//  UIApplication+Extensions.swift
//  TheDatingApp
//
//  Created by HalitGUMUS on 22.09.2019.
//  Copyright © 2019 HalitGUMUS. All rights reserved.
//

import UIKit

// MARK: - `UIApplication` extensions
public extension UIApplication {
    
    /// Application display name.
    public var name: String {
        let displayName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
        let budleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
        return displayName ?? budleName ?? ""
    }
    
    /// App version
    public var version: String {
        return (Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String) ?? "0.0.0"
    }
    
    /// App platform (iOS)
    public var platform: String {
        return "iOS"
    }
    
    /// Browser's user agent string.
    public var userAgent: String? {
        let view = UIWebView()
        return view.stringByEvaluatingJavaScript(from: "navigator.userAgent")
    }
    
    /// App build number.
    public var build: String? {
        return (Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String)
    }
    
}
