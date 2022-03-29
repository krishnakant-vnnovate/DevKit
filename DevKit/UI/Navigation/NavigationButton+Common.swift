//
//  NavigationButton+Common.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

public extension NavigationButton {
    
    typealias ActionHandler = () -> Void
    
    static func backArrow(action: @escaping ActionHandler) -> NavigationButton {
        return .init(buttonType: .image(Image.backArrowWhite), closure: action)
    }
    
    static func dismiss(action: @escaping ActionHandler) -> NavigationButton {
        return .init(buttonType: .image(Image.dismissButtonWhite), closure: action)
    }
    
    static func text(_ text: String, action: @escaping ActionHandler) -> NavigationButton {
        return .init(buttonType: .text(text, .white), closure: action)
    }
    
    static func support(action: @escaping ActionHandler) -> NavigationButton {
        return  .init(buttonType: .image(Image.supportBubble), closure: action)
    }
    
    static func tooltip(action: @escaping ActionHandler) -> NavigationButton {
        return .init(buttonType: .image(Image.glossary), closure: action)
    }
    
    static func about(action: @escaping ActionHandler) -> NavigationButton {
        return .init(buttonType: .image(Image.aboutIcon), closure: action)
    }
    
    static func threeDots(action: @escaping ActionHandler) -> NavigationButton {
        return .init(buttonType: .image(Image.moreMenuVertical), closure: action)
    }
    
    static func settings(action: @escaping ActionHandler) -> NavigationButton {
        return .init(buttonType: .image(Image.settings), closure: action)
    }
}
