//
//  TDAlert.swift
//  TheDatingApp
//
//  Created by HalitGUMUS on 31.08.2019.
//  Copyright © 2019 HalitGUMUS. All rights reserved.
//

import SwiftMessages

/// Offers a quick way to show user alerts using SwiftMessages
final class TDAlert {
    
    var title: String?
    var body: String?
    var layout: MessageView.Layout = .statusLine
    var theme: Theme = .warning
    
    weak private var message: MessageView!
    var config: SwiftMessages.Config!
    
    init(title: String? = nil, body: String?, layout: MessageView.Layout = MessageView.Layout.cardView, theme: Theme = Theme.warning, allowDismiss: Bool = true) {
        
        SwiftMessages.pauseBetweenMessages = 0
        
        self.title = title
        self.body = body
        
        let message = MessageView.viewFromNib(layout: layout)
        message.configureTheme(theme)
        message.button?.isHidden = true
        
        if title == nil {
            message.titleLabel?.isHidden = true
        }
        
        var config = SwiftMessages.Config()
        config.presentationContext = .window(windowLevel: .statusBar)
        config.preferredStatusBarStyle = .lightContent
        config.presentationStyle = .top
        config.dimMode = .none
        config.shouldAutorotate = true
        config.duration = .automatic
        
        message.titleLabel?.text = title
        message.bodyLabel?.text = body
        
        if allowDismiss {
            message.tapHandler = { _ in
                SwiftMessages.sharedInstance.hide()
            }
        }
        
        self.message = message
        self.config = config
        
    }
    
    convenience init(error: Error) {
        self.init(body: error.localizedDescription, theme: .error)
    }
    
    convenience init(errorMessage: String) {
        self.init(body: errorMessage, theme: .error)
    }
    
    convenience init(successMessage: String) {
        self.init(body: successMessage, theme: .success)
    }
    
    func show() {
        SwiftMessages.hideAll()
        SwiftMessages.show(config: config, view: message)
    }
    
}
