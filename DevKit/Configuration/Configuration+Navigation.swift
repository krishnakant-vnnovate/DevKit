//
//  Configuration+Navigation.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/9/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import Foundation

public extension Configuration {
    
    struct Navigation {
        public let titleColor: UIColor
        public let titleFont: UIFont
        public let buttonFont: UIFont
        
        public init(titleColor: UIColor = .white,
                    titleFont: UIFont = .boldSystemFont(ofSize: 16),
                    buttonFont: UIFont = .systemFont(ofSize: 14, weight: .medium)) {
            self.titleColor = titleColor
            self.titleFont = titleFont
            self.buttonFont = buttonFont
        }
    }
}
