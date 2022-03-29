//
//  NavigationButton.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit

public struct NavigationButton {
    
    public let buttonType: ButtonType
    public let closure: () -> Void
    
    public enum ButtonType {
        case text(String, UIColor)
        case attributedText(NSAttributedString)
        case image(ImageInterface)
        case circular(ImageInterface)
    }
    
    public init(buttonType: ButtonType, closure: @escaping () -> Void) {
        self.buttonType = buttonType
        self.closure = closure
    }
}

extension NavigationButton.ButtonType: Equatable {
    
    public static func == (lhs: NavigationButton.ButtonType, rhs: NavigationButton.ButtonType) -> Bool {
        switch (lhs, rhs) {
        case (.text(let leftText, let leftColor), .text(let rightText, let rightColor)):
            return leftText == rightText && leftColor == rightColor
        case (.attributedText(let leftString), .attributedText(let rightString)):
            return leftString == rightString
        case (.image(let leftInterface), .image(let rightInterface)):
            return leftInterface.image == rightInterface.image
        case (.circular(let leftInterface), .circular(let rightInterface)):
            return leftInterface.image == rightInterface.image
        case (.text, _),
             (.attributedText, _),
             (.image, _),
             (.circular, _):
            return false
        }
    }
}

extension NavigationButton: Equatable {
    
    public static func == (lhs: NavigationButton, rhs: NavigationButton) -> Bool {
        return lhs.buttonType == rhs.buttonType
    }
}
