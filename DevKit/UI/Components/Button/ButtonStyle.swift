//
//  ButtonStyle.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit

public enum ButtonStyle {
    case primary(UIColor)
    case custom(ButtonAppearanceModel)
    case dismiss(UIColor)
    case underlined(UIColor)
    case hollow(UIColor)
    case clear(UIColor)
    
    public var model: ButtonAppearanceModel {
        switch self {
        case .primary:
            return .primary
        case .custom(let appearanceModel):
            return appearanceModel
        case .dismiss(let textColor):
            return .dismiss(textColor: textColor)
        case .underlined(let textColor):
            return .underlined(textColor: textColor)
        case .hollow(let color):
            return .hollow(color: color)
        case .clear(let color):
            return .clear(textColor: color)
        }
    }
    
    public func update(withColor color: UIColor) -> ButtonStyle {
        switch self {
        case .primary:
            return .primary(color)
        case .dismiss:
            return .dismiss(color)
        case .underlined:
            return .underlined(color)
        case .clear:
            return .clear(color)
        case .custom, .hollow:
            return self
        }
    }
    
    public var description: String {
        switch self {
        case .primary:
            return "primary"
        case .custom:
            return "endless possibilities"
        case .underlined:
            return "underlined"
        case .hollow:
            return "hollow"
        case .clear:
            return "clear"
        case .dismiss:
            return "dismiss"
        }
    }
    
}

public enum EdgeType {
    case sharp
    case semicircle
    case round
    case custom(radius: CGFloat)
    
    public static var defaultOne: EdgeType {
        return .semicircle
    }
    
    func cornerRadius(_ view: UIView) -> CGFloat {
        switch self {
        case .custom(let v):
            return v
        case .semicircle:
            return view.frame.height / 2
        case .round:
            return 8
        case .sharp:
            return 0
        }
    }
    
}

public struct ButtonAppearanceModel {
    
    public var font: UIFont
    public var numberOfLines: Int = 1
    public var textAlignment = NSTextAlignment.center
    public var edgeType = EdgeType.defaultOne
    public var textColor: UIColor
    public var color: UIColor
    public var borderColor: UIColor = .clear
    public var borderWidth: CGFloat = .leastNormalMagnitude
    
    public init(font: UIFont, textColor: UIColor, backgroundColor: UIColor? = nil, edgeType: EdgeType = EdgeType.defaultOne, borderColor: UIColor = .clear, borderWidth: CGFloat = .leastNormalMagnitude) {
        self.font = font
        self.textColor = textColor
        self.color = backgroundColor ?? .clear
        self.edgeType = edgeType
        self.borderColor = borderColor
        self.borderWidth = borderWidth
    }
    
    public static var primary: ButtonAppearanceModel {
        return ButtonAppearanceModel(font: .buttonTitle,
                                     textColor: .white,
                                     backgroundColor: Configuration.shared.buttons.primaryButton.backgroundColor,
                                     edgeType: .defaultOne)
    }
    
    public static func dismiss(textColor: UIColor) -> ButtonAppearanceModel {
        return ButtonAppearanceModel(font: .buttonTitle, textColor: textColor)
    }
    
    public static func underlined(textColor: UIColor) -> ButtonAppearanceModel {
        return ButtonAppearanceModel(font: .buttonTitle,
                                     textColor: textColor,
                                     backgroundColor: nil,
                                     edgeType: .defaultOne)
    }
    
    public static func hollow(color: UIColor) -> ButtonAppearanceModel {
        return ButtonAppearanceModel(font: .buttonTitle,
                                     textColor: color,
                                     backgroundColor: .clear,
                                     edgeType: .defaultOne,
                                     borderColor: color,
                                     borderWidth: 2)
    }
    
    public static func clear(textColor: UIColor) -> ButtonAppearanceModel {
        return ButtonAppearanceModel(font: .buttonTitle,
                                     textColor: textColor,
                                     backgroundColor: .clear,
                                     edgeType: .defaultOne)
    }
}

private extension UIFont {
    static let buttonTitle = UIFont.boldSystemFont(ofSize: 16)
}
