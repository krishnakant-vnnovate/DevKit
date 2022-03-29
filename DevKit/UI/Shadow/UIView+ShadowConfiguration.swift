//
//  UIView+ShadowConfiguration.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import Foundation

public extension UIView {
    
    func addShadow(config: ShadowConfiguration) {
        layer.addShadow(config: config)
    }
    
    func removeShadow() {
        layer.removeShadow()
    }
    
}
