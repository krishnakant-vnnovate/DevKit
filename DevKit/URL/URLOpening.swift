//
//  URLOpening.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit

public protocol URLOpening {
    
    typealias Opened = Bool
    
    @discardableResult
    func openURL(_ url: URL?) -> Opened
    func canOpenURL(_ url: URL?) -> Bool
    
    var statusBarFrameHeight: CGFloat { get }
    var keyWindow: UIWindow? { get }
    
}
