//
//  ApplicationURLOpener.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit

class ApplicationURLOpener {
    let application: UIApplication
    
    init(application: UIApplication) {
        self.application = application
    }
}

extension ApplicationURLOpener: URLOpening {
    
    public var statusBarFrameHeight: CGFloat { return application.statusBarFrame.height }
    
    public var keyWindow: UIWindow? { return application.keyWindow }
    
    func openURL(_ url: URL?) -> URLOpening.Opened {
        guard let url = url, canOpenURL(url) else {
            return false
        }
        
        application.open(url, options: [:], completionHandler: nil)
        
        return true
    }
    
    func canOpenURL(_ url: URL?) -> Bool {
        guard let url = url else { return false }
        return application.canOpenURL(url)
    }
}
