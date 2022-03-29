//
//  CGGradientLayer+GradientLayerViewModel.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit

extension CAGradientLayer {
    
    func configure(with viewModel: GradientLayerViewModel) {
        startPoint = viewModel.startPoint
        endPoint = viewModel.endPoint
        locations = viewModel.locations
        colors = viewModel.colors
    }
    
}
