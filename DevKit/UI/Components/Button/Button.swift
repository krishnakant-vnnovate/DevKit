//
//  Button.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit

public class Button: UIButton {
    
    private let backgroundLayer = CALayer()
    public var contractsWhenHighlighted: Bool = false
    
    public var placeImageOnLeft: Bool = false {
        didSet {
            updateLayout()
        }
    }
    
    public var color: UIColor = .clear {
        didSet {
            update()
        }
    }
    
    public var textColor: UIColor = .white {
        didSet {
            update()
        }
    }
    
    public var cornerRadius: CGFloat = 0 {
        didSet {
            update()
        }
    }
    
    public var edgeType: EdgeType = .semicircle {
        didSet {
            update()
        }
    }
    
    public var borderColor: UIColor? = .clear {
        didSet {
            update()
        }
    }
    
    public var borderWidth: CGFloat = 0 {
        didSet {
            update()
        }
    }
    
    public var underlined: Bool = false {
        didSet {
            update()
        }
    }
    
    public var style: ButtonStyle = .clear(.lightText) {
        didSet {
            alter(for: style)
        }
    }
    
    required public init() {
        super.init(frame: .zero)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public override var isHighlighted: Bool {
        didSet {
            let alphaAmount: CGFloat = color == .clear ? 0 : 0.3
            let darkColor = color.blend(with: .black, amount: alphaAmount)
            if isHighlighted {
                backgroundLayer.backgroundColor = darkColor.cgColor
            } else {
                backgroundLayer.backgroundColor = color.cgColor
            }
            
            if !contractsWhenHighlighted {
                return
            }
            
            let transform = isHighlighted ? CGAffineTransform(scaleX: 0.9, y: 0.9) : .identity
            UIView.animate(withDuration: 0.1) {
                self.transform = transform
            }
        }
    }
    
    override public var isEnabled: Bool {
        didSet {
            let alphaAmount: CGFloat = color == .clear ? 0 : 0.3
            let lightColor = color.blend(with: .white, amount: alphaAmount)
            if isEnabled {
                backgroundLayer.backgroundColor = color.cgColor
            } else {
                backgroundLayer.backgroundColor = lightColor.cgColor
            }
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        backgroundLayer.cornerRadius = edgeType.cornerRadius(self)
        backgroundLayer.borderColor = borderColor?.cgColor
        backgroundLayer.borderWidth = borderWidth
        backgroundLayer.frame = bounds
        layer.insertSublayer(backgroundLayer, at: 0)
    }
    
    public override func setImage(_ image: UIImage?, for state: UIControl.State) {
        super.setImage(image, for: state)
        update()
    }
    
    public override func setTitle(_ title: String?, for state: UIControl.State) {
        let alphaAmount: CGFloat = 0.4
        
        let highlightedTextColor = textColor.withAlphaComponent(alphaAmount)
        let disabledTextColor = textColor.withAlphaComponent(alphaAmount)
        
        if let font = titleLabel?.font, let text = title {
            var attrText: NSAttributedString = text.attributedStyle(font: font, textColor: textColor)
            var attrTextHighlighted: NSAttributedString = text.attributedStyle(font: font, textColor: highlightedTextColor)
            var attrTextDisabled: NSAttributedString = text.attributedStyle(font: font, textColor: disabledTextColor)
            if isUnderlined {
                attrText = text.underlined(with: textColor , font: font)
                attrTextHighlighted = text.underlined(with: highlightedTextColor, font: font)
                attrTextDisabled = text.underlined(with: disabledTextColor, font: font)
            }
            
            super.setAttributedTitle(attrTextHighlighted, for: .highlighted)
            super.setAttributedTitle(attrTextDisabled, for: .disabled)
            super.setAttributedTitle(attrText, for: .normal)
        }
    }
}

private extension Button {
    
    func setup() {
        backgroundColor = .clear
        titleLabel?.font = .boldSystemFont(ofSize: 16)
        titleLabel?.textAlignment = .center
        backgroundLayer.backgroundColor = color.cgColor
        isEnabled = true
        isHighlighted = false
    }
    
    func update() {
        backgroundLayer.backgroundColor = color.cgColor
        setTitle(titleLabel?.text, for: .normal, animated: false)
        updateLayout()
    }
    
    func updateLayout() {
        if let image = imageView?.image {
            if placeImageOnLeft {
                titleEdgeInsets = UIEdgeInsets.init(top: 0, left: (image.size.width * 0.5), bottom: 0, right: 0)
                imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: (image.size.width * 0.5))
            } else {
                titleEdgeInsets = UIEdgeInsets.init(top: 0, left: -image.size.width, bottom: 0, right: 0)
                imageEdgeInsets = UIEdgeInsets.init(top: 0, left: frame.width - frame.height / 2 - image.size.width, bottom: 0, right: 0)
            }
        }
    }
    
    var isUnderlined: Bool {
        if case .underlined = style {
            return true
        }
        return underlined
    }
    
    func alter(for type: ButtonStyle) {
        let style = type.model
        titleLabel?.font = style.font
        titleLabel?.numberOfLines = 0
        titleLabel?.textAlignment = .center
        borderColor = style.borderColor
        borderWidth = style.borderWidth
        edgeType = style.edgeType
        color = style.color
        textColor = style.textColor
        showsTouchWhenHighlighted = false
        adjustsImageWhenHighlighted = true
    }
    
    func setImageOnLeft(image: UIImage?, tintColor: UIColor) {
        placeImageOnLeft = true
        imageView?.tintColor = tintColor
        setImage(image, for: .normal)
        setImage(image, for: .highlighted)
    }
}

extension String {
    
    func underlined(with textColor: UIColor, font: UIFont) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: [.font : font,
                                                             .foregroundColor : textColor,
                                                             .underlineStyle : NSUnderlineStyle.single.rawValue,
                                                             .underlineColor : textColor])
    }
}
