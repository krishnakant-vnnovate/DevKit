//
//  GradientLayerViewModel.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit

struct GradientLayerViewModel {
    let colors: [CGColor]
    let startPoint: CGPoint
    let endPoint: CGPoint
    let locations: [NSNumber]
}

extension GradientLayerViewModel {
    
    init(configuration: GradientConfiguration) {
        let colorsAndLocations = configuration.colorsAndLocations
        colors = colorsAndLocations.map { $0.0.cgColor }
        startPoint = configuration.direction.startPoint
        endPoint = configuration.direction.endPoint
        locations = colorsAndLocations.map { $0.1 as NSNumber }
    }
    
}

//MARK: Helpers
private extension GradientDirection {
    
    var startPoint: CGPoint {
        switch self {
        case .down:
            return .init(x: 0.5, y: 0)
        case .right:
            return .init(x: 0, y: 0.5)
        case .up:
            return .init(x: 0.5, y: 1)
        case .left:
            return .init(x: 1, y: 0.5)
        }
    }
    
    var endPoint: CGPoint {
        switch self {
        case .down:
            return GradientDirection.up.startPoint
        case .right:
            return GradientDirection.left.startPoint
        case .up:
            return GradientDirection.down.startPoint
        case .left:
            return GradientDirection.right.startPoint
        }
    }
    
}
