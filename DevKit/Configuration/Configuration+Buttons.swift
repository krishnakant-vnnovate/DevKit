//
//  Configuration+Buttons.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/9/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import Foundation

public extension Configuration {
    
    struct Buttons {
        let primaryButton: Button
        
        public init(primaryButton: Button = Button()) {
            self.primaryButton = primaryButton
        }
    }
}

public extension Configuration {

    struct Button {
        let textColor: UIColor
        let font: UIFont
        let backgroundColor: UIColor
        
        public init(textColor: UIColor = .blue, font: UIFont = .systemFont(ofSize: 14, weight: .medium), backgroundColor: UIColor = .clear) {
            self.textColor = textColor
            self.font = font
            self.backgroundColor = backgroundColor
        }
    }
}
