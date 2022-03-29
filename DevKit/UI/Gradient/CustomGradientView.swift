//
//  CustomGradientView.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit

public class CustomGradientView: UIView {
    
    override public class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    private var gradientLayer: CAGradientLayer? {
        return layer as? CAGradientLayer
    }
    
    private func setup() {
        backgroundColor = .clear
        clipsToBounds = true
        gradientLayer?.speed = 10
    }
    
    public func configure(with configuration: GradientConfiguration) {
        setup()
        gradientLayer?.configure(with: .init(configuration: configuration))
    }
    
}
