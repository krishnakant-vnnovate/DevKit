//
//  ButtonViewModel.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import Foundation

public struct ButtonViewModel {
    public enum Style: String, CaseIterable {
        case primary
        case dismissWhiteText
        case clearWhiteText
        case clearGrayText
        case underlinedWhiteText
        case underlinedGrayText
    }
    
    public let title: String?
    public let image: ImageInterface?
    public let style: Style
    public let action: (() -> Void)
    public let accessibilityIdentifier: String?
    public var isEnabled: Bool
    
    public init(title: String?, image: ImageInterface?, style: Style, accessibilityIdentifier: String? = nil, isEnabled: Bool = true, action: @escaping () -> Void) {
        self.title = title
        self.image = image
        self.style = style
        self.accessibilityIdentifier = accessibilityIdentifier
        self.isEnabled = isEnabled
        self.action = action
    }
}

extension ButtonViewModel {
    
    public var buttonStyle: ButtonStyle {
        switch self.style {
        case .primary:
            return ButtonStyle.primary(Configuration.shared.buttons.primaryButton.backgroundColor)
        case .dismissWhiteText:
            return ButtonStyle.dismiss(.white)
        case .clearWhiteText:
            return ButtonStyle.clear(.white)
        case .clearGrayText:
            return ButtonStyle.clear(.lightText)
        case .underlinedWhiteText:
            return ButtonStyle.underlined(.white)
        case .underlinedGrayText:
            return ButtonStyle.underlined(.lightText)
        }
    }
}


public extension Button {
    
    convenience init(viewModel: ButtonViewModel) {
        self.init(frame: .zero)
        configure(with: viewModel)
    }
    
    func style(with viewModel: ButtonViewModel) {
        style = viewModel.buttonStyle
        accessibilityIdentifier = viewModel.accessibilityIdentifier
        didTap = {
            viewModel.action()
        }
        setTitle(viewModel.title, for: .normal)
        setImage(viewModel.image?.image, for: .normal)
        isEnabled = viewModel.isEnabled
    }
}

public extension UIButton {
    
    func configure(with viewModel: ButtonViewModel) {
        didTap = viewModel.action
        setTitle(viewModel.title, for: .normal)
        setImage(viewModel.image?.image, for: .normal)
        isEnabled = viewModel.isEnabled
    }
}
