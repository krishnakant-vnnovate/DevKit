//
//  NavigationViewModel+Common.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit

public extension NavigationViewModel {
    
    static var empty: NavigationViewModel {
        return NavigationViewModel(with: "")
    }
    
    static func emptyTitle(leftButton: NavigationButton? = nil, rightButton: NavigationButton? = nil) -> NavigationViewModel {
        return NavigationViewModel(with: "", leftButton: leftButton, rightButton: rightButton)
    }
    
    static func leftBackButton(withNavigationBarTitle title: String, _ action: @escaping () -> Void) -> NavigationViewModel {
        let backButton = NavigationButton.backArrow(action: action)
        return NavigationViewModel(with: title, leftButton: backButton)
    }
    
    static func leftXButton(withNavigationBarTitle title: String, _ action: @escaping () -> Void) -> NavigationViewModel {
        let backButton = NavigationButton.dismiss(action: action)
        return NavigationViewModel(with: title, leftButton: backButton)
    }
    
    static func leftXButton(action: @escaping () -> Void) -> NavigationViewModel {
        return leftXButton(withNavigationBarTitle: "", action)
    }
    
    static func leftBackButton(action: @escaping () -> Void) -> NavigationViewModel {
        return leftBackButton(withNavigationBarTitle: "", action)
    }
    
    static func leftTextButton(withNavigationBarTitle title: String, leftText: String, _ action: @escaping () -> Void) -> NavigationViewModel {
        let leftButton = NavigationButton.text(leftText, action: action)
        return NavigationViewModel(with: title, leftButton: leftButton)
    }
    
    static func leftXRightSupport(withTitle title: String = "", leftAction: @escaping () -> Void, rightAction: @escaping () -> Void) -> NavigationViewModel {
        let backButton = NavigationButton.dismiss(action: leftAction)
        let supportButton = NavigationButton.support(action: rightAction)
        return NavigationViewModel(with: title, leftButton: backButton, rightButton: supportButton)
    }
    
    static func leftBackRightSupport(withTitle title: String = "", leftAction: @escaping () -> Void, rightAction: @escaping () -> Void) -> NavigationViewModel {
        let backButton = NavigationButton.backArrow(action: leftAction)
        let supportButton = NavigationButton.support(action: rightAction)
        
        return NavigationViewModel(with: title, leftButton: backButton, rightButton: supportButton)
    }
    
    static func leftBackRightTooltip(withTitle title: String, leftAction: @escaping () -> Void, rightAction: @escaping () -> Void) -> NavigationViewModel {
        let backButton = NavigationButton.backArrow(action: leftAction)
        let tooltipButton = NavigationButton.tooltip(action: rightAction)
        
        return NavigationViewModel(with: title, leftButton: backButton, rightButton: tooltipButton)
    }
    
    static func leftBack(withTitle title: String, leftAction: @escaping () -> Void, rightText: String, rightAction: @escaping () -> Void) -> NavigationViewModel {
        let backButton = NavigationButton.backArrow(action: leftAction)
        let rightButton = NavigationButton.text(rightText, action: rightAction)
        
        return NavigationViewModel(with: title, leftButton: backButton, rightButton: rightButton)
    }
    
    static func leftX(withTitle title: String, leftAction: @escaping () -> Void, rightText: String, rightAction: @escaping () -> Void) -> NavigationViewModel {
        let backButton = NavigationButton.dismiss(action: leftAction)
        let rightButton = NavigationButton.text(rightText, action: rightAction)
        
        return NavigationViewModel(with: title, leftButton: backButton, rightButton: rightButton)
    }
    
    static func leftXRightTooltip(withTitle title: String, leftAction: @escaping () -> Void, rightAction: @escaping () -> Void) -> NavigationViewModel {
        let backButton = NavigationButton.dismiss(action: leftAction)
        let tooltipButton = NavigationButton.tooltip(action: rightAction)
        
        return NavigationViewModel(with: title, leftButton: backButton, rightButton: tooltipButton)
    }
    
    static func rightSupport(withTitle title: String = "", action: @escaping () -> Void) -> NavigationViewModel {
        let supportButton = NavigationButton.support(action: action)
        return NavigationViewModel(with: title, rightButton: supportButton)
    }
    
    static func leftXButton(withClearBarAndTitle title: String, action: @escaping () -> Void) -> NavigationViewModel {
        let backButton = NavigationButton.dismiss(action: action)
        return NavigationViewModel(with: title, leftButton: backButton)
    }
    
    static func leftBackButton(withClearBarAndTitle title: String, action: @escaping () -> Void) -> NavigationViewModel {
        let backButton = NavigationButton.backArrow(action: action)
        return NavigationViewModel(with: title, leftButton: backButton)
    }
    
    static func leftRightTextButtons(withTitle title: String, leftText: String, leftAction: @escaping () -> Void, rightText: String, rightAction: @escaping () -> Void) -> NavigationViewModel {
        let leftButton = NavigationButton.text(leftText, action: leftAction)
        let rightButton = NavigationButton.text(rightText, action: rightAction)
        
        return NavigationViewModel(with: title, leftButton: leftButton, rightButton: rightButton)
    }
    
    static func leftXRightHelp(withTitle title: String = "", leftAction: @escaping () -> Void, rightAction: @escaping () -> Void) -> NavigationViewModel {
        let backButton = NavigationButton.dismiss(action: leftAction)
        let helpButton = NavigationButton(buttonType: .image(Image.aboutIcon), closure: rightAction)
        
        return NavigationViewModel(with: title, leftButton: backButton, rightButton: helpButton)
    }
    
    static func leftBackRightHelp(withTitle title: String = "", leftAction: @escaping () -> Void, rightAction: @escaping () -> Void) -> NavigationViewModel {
        let backButton = NavigationButton.backArrow(action: leftAction)
        let helpButton = NavigationButton.about(action: rightAction)
        
        return NavigationViewModel(with: title, leftButton: backButton, rightButton: helpButton)
    }
    
    static func leftBackRightVerticalMenu(withTitle title: String = "", leftAction: @escaping () -> Void, rightAction: @escaping () -> Void) -> NavigationViewModel {
        let backButton = NavigationButton.backArrow(action: leftAction)
        let menuButton = NavigationButton.threeDots(action: rightAction)
        
        return NavigationViewModel(with: title, leftButton: backButton, rightButton: menuButton)
    }
    
    static func leftBackWithMultipleRightButtons(withTitle title: String = "", leftAction: @escaping () -> Void, rightButtons: [NavigationButton]) -> NavigationViewModel {
        let backButton = NavigationButton.backArrow(action: leftAction)
        return NavigationViewModel(with: title, leftButton: backButton, rightButtons: rightButtons)
    }
    
}
