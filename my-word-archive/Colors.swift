//
//  Colors.swift
//  my-word-archive
//
//  Created by HalitGUMUS on 14.09.2019.
//  Copyright © 2019 HalitGUMUS. All rights reserved.
//

import UIKit

struct Colors {
    
    struct Gradient {
        static let start = UIColor.clear
        static let end = UIColor.black.withAlphaComponent(0.57)
        static let options = GradientableOptions(colors: [start, end], direction: GradientableOptions.Direction.bottom)
    }
    
    static let defaultBackground = Color(hex: "F5F6F9")! //171A35
    static let defaultHeaderBackground = Color(hex: "27314B")!
    static let defaultButton = Color(hex: "D8D8D8")!
    static let gradientPillButtonTitle = Color(hex: "FFFFFF")!
    static let gradientStart = Color(hex: "FE9401")!
    static let gradientEnd = Color(hex: "FF5f37")!
    static let appPurpleColor = Color(hex: "FE5068")!
    static let appGrayColor = Color(hex: "474747")!
    
    static let loadingableTint = Color(hex: "2E5BB9")!
    static let carnation = Color(hex: "FF7593")!
    static let blueGrey = Color(hex: "7e889b")!
    static let steel = Color(hex: "6c7c94")!
    static let steel2 = Color(hex: "7f8184")!
    static let pinkishOrange = Color(hex: "ff674c")!
    static let title = Color(hex: "adb6c9")!
    static let primary = Color(hex: "adb6c9")!
    static let veryLightBlue = Color(hex: "e2e8f5")!
    static let paleMagenta = Color(hex: "e861cd")!
    static let niceBlue = Color(hex: "158ba6")!
    static let windowsBlue = Color(hex: "36a5bf")!
    static let slateGrey = Color(hex: "5c6371")!
    static let battleshipGrey = Color(hex: "717989")!
    static let goldenYellow = Color(hex: "ffc61b")!
    static let weirdGreen = Color(hex: "4bd865")!
    static let veryLightBlueTwo = Color(hex: "dee6f6")!
    static let purpleBlue = Color(hex: "6c16bc")!
    static let sliderTint = Color(hex: "cd1733")!
    static let lipstick = Color(hex: "cd1733")!
    static let darkGreyBlue = Color(hex: "2c3e4f")!
    static let redPink = Color(hex: "f1304d")!
    static let pinkyRed = Color(hex: "ef2f4c")!
    static let reddishPink = Color(hex: "f53d63")!
    static let darkTwo = Color(hex: "1e2832")!
    static let darkThree = Color(hex: "1d2a38")!
    static let paleSalmon = Color(hex: "ffaca4")!
    static let lightPeach = Color(hex: "d9d5d5")!
    static let lightBurgundy = Color(hex: "b72c41")!
    static let brownGrey = Color(hex: "9c9c9c")!
    static let slate = Color(hex: "3e5367")!
    static let dark = Color(hex: "253240")!
    static let veryLightPink = Color(hex: "b8b8b8")!
    static let lightPeachTwo = Color(hex: "b6b6b6")!
    
}
