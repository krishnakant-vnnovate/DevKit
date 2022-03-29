//
//  NavigationViewModel.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit

public struct NavigationViewModel {
    
    public enum TitleType {
        case text(String)
        case searchBar(String, UISearchBarDelegate)
    }
    
    public let type: TitleType
    public let leftButton: NavigationButton?
    public let rightButtons: [NavigationButton]
    
    public init(with type: TitleType, leftButton: NavigationButton? = nil, rightButton: NavigationButton? = nil) {
        let rightBarButtons = [rightButton].compactMap { $0 }
        self.init(with: type, leftButton: leftButton, rightButtons: rightBarButtons)
    }
    
    var isVisible: Bool {
        guard case .text(let title) = type else {
            return true
        }
        
        return title.isEmpty && leftButton == nil && rightButtons.isEmpty
    }
}

public extension NavigationViewModel {
    
    init(with type: TitleType, leftButton: NavigationButton? = nil, rightButtons: [NavigationButton]) {
        self.type = type
        self.leftButton = leftButton
        self.rightButtons = rightButtons
    }
    
    init(with title: String, leftButton: NavigationButton? = nil, rightButton: NavigationButton? = nil) {
        self.init(with: .text(title), leftButton: leftButton, rightButton: rightButton)
    }
    
    init(with title: String, leftButton: NavigationButton? = nil, rightButtons: [NavigationButton]) {
        self.init(with: .text(title), leftButton: leftButton, rightButtons: rightButtons)
    }
}
