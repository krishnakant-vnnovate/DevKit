//
//  ShadowConfiguration.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit

public struct ShadowConfiguration {
    public let color: UIColor
    public let alpha: Float
    public let offset: CGPoint
    public let blur: CGFloat
    public let spread: CGFloat
    
    public init(color: UIColor, alpha: Float, offset: CGPoint, blur: CGFloat, spread: CGFloat) {
        self.color = color
        self.alpha = alpha
        self.offset = offset
        self.blur = blur
        self.spread = spread
    }
}

// MARK: Defined
public extension ShadowConfiguration {
    
    static var `default`: ShadowConfiguration {
        return .init(color: .black, alpha: 0.38, offset: .init(x: 0, y: 2), blur: 3, spread: 0)
    }
    
    static var defaultNoOffset: ShadowConfiguration {
        return .init(color: .black, alpha: 0.38, offset: .init(x: 0, y: 0), blur: 3, spread: 0)
    }
    
}

