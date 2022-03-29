//
//  GradientConfiguration.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit

public typealias GradientDirection = GradientConfiguration.GradientDirection

public struct GradientConfiguration {
    
    public enum GradientDirection {
        case up
        case down
        case left
        case right
    }
    
    public let colorsAndLocations: [(UIColor, CGFloat)]
    public let direction: GradientDirection
    
    public init(colorsAndLocations: [(UIColor, CGFloat)], direction: GradientDirection) {
        self.colorsAndLocations = colorsAndLocations.map { color, location in
            let formattedColor = color == .clear ? .cgClear : color
            let formattedLocation = max(0, min(location, 1))
            return (formattedColor, formattedLocation)
        }
        
        self.direction = direction
    }
    
}

// MARK: Convenience initializers
extension GradientConfiguration {
    
    public init(colors: [UIColor], direction: GradientDirection) {
        let colorsAndLocations = colors.enumerated().map { offset, color in
            (color, CGFloat(offset)/max(1, CGFloat(colors.count-1)))
        }
        self.init(colorsAndLocations: colorsAndLocations, direction: direction)
    }
    
    public init(color: UIColor, solidColorProgress: CGFloat = 0, direction: GradientDirection) {
        self.init(
            colorsAndLocations: [
                (color, 0),
                (color, solidColorProgress),
                (color.withAlphaComponent(0), 1)  // .clear shows of white transparency
            ],
            direction: direction
        )
    }
    
}
