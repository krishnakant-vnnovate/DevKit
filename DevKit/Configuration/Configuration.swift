//
//  Configuration.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import Foundation

public struct Configuration {
    
    public private(set) static var shared = Configuration()
    
    public let navigation: Navigation
    public let buttons: Buttons
    public let images: Images
    
    public init(navigation: Navigation = Navigation(), buttons: Buttons = Buttons(), images: Images = Images()) {
        self.navigation = navigation
        self.buttons = buttons
        self.images = images
    }
}

// MARK: Public API
public extension Configuration {
    
    static func apply(configuration: Configuration) {
        shared = configuration
    }
}
