//
//  CALayer+ShadowConfiguration.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import Foundation

public extension CALayer {
    
    func addShadow(config: ShadowConfiguration) {
        shadowColor = config.color.cgColor
        shadowOpacity = config.alpha
        shadowOffset = CGSize(width: config.offset.x, height: config.offset.y)
        shadowRadius = config.blur / 2
        masksToBounds = false
        
        if config.spread == 0 {
            shadowPath = nil
        } else {
            let dx = -config.spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
    
    func removeShadow() {
        shadowPath = nil
        shadowColor = nil
        shadowOffset = .zero
        shadowRadius = 0
        shadowOpacity = 0
    }
    
}
