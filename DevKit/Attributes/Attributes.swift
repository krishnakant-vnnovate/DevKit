//
//  Attributes.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import Foundation
import UIKit

public struct Attributes {
    
    public let attributes: [NSAttributedString.Key: Any]
    
    public init() {
        self.attributes = [:]
    }
    
    public init(_ attributes: [NSAttributedString.Key: Any]? = nil) {
        self.attributes = attributes ?? [:]
    }
    
    private func withUpdatedAttributes(_ attributes: [NSAttributedString.Key: Any]) -> Attributes {
        return Attributes(self.attributes.updated(with: attributes))
    }
    
    public func withFont(_ font: UIFont) -> Attributes {
        return withUpdatedAttributes([.font: font])
    }
    
    public func withForegroundColor(_ foregroundColor: UIColor) -> Attributes {
        return withUpdatedAttributes([.foregroundColor: foregroundColor])
    }
    
    public func withStroke(color: UIColor, width: CGFloat) -> Attributes {
        return withUpdatedAttributes([.strokeColor: color, .strokeWidth: -1 * width])
    }
    
    public func withStrikethrough(color: UIColor, style: NSUnderlineStyle = NSUnderlineStyle.thick) -> Attributes {
        return withUpdatedAttributes([.strikethroughStyle: style.rawValue, .strikethroughColor: color])
    }
    
    public func withUnderline(_ underlineStyle: NSUnderlineStyle = NSUnderlineStyle.single) -> Attributes {
        return withUpdatedAttributes([.underlineStyle: underlineStyle.rawValue])
    }
    
    public func withLink(_ link: String) -> Attributes {
        return withUpdatedAttributes([.link: link])
    }
    
    public func withUnderlineColor(_ underlineColor: UIColor) -> Attributes {
        return withUpdatedAttributes([.underlineColor: underlineColor])
    }
    
    public func withLetterSpacing(_ letterSpacing: CGFloat) -> Attributes {
        return withUpdatedAttributes([.kern: letterSpacing])
    }
    
    public func withBaselineOffset(_ offset: CGFloat) -> Attributes {
        return withUpdatedAttributes([.baselineOffset: offset])
    }
    
    // MARK: Paragraph style
    private func editableParagraphStyle() -> NSMutableParagraphStyle {
        return ((attributes[.paragraphStyle] as? NSParagraphStyle)?.mutableCopy() as? NSMutableParagraphStyle) ?? NSMutableParagraphStyle()
    }
    
    public func withUpdatedParagraphStyle(_ paragraphStyle: NSParagraphStyle) -> Attributes {
        return withUpdatedAttributes([.paragraphStyle: paragraphStyle])
    }
    
    public func withLineHeight(_ lineHeight: CGFloat) -> Attributes {
        let newParagraphStyle = editableParagraphStyle()
        newParagraphStyle.minimumLineHeight = lineHeight
        newParagraphStyle.maximumLineHeight = lineHeight
        
        return withUpdatedParagraphStyle(newParagraphStyle)
    }
    
    public func withLineSpacing(_ lineSpacing: CGFloat) -> Attributes {
        let newParagraphStyle = editableParagraphStyle()
        newParagraphStyle.lineSpacing = lineSpacing
        
        return withUpdatedParagraphStyle(newParagraphStyle)
    }
    
    public func withAlignment(_ alignment: NSTextAlignment) -> Attributes {
        let newParagraphStyle = editableParagraphStyle()
        newParagraphStyle.alignment = alignment
        
        return withUpdatedParagraphStyle(newParagraphStyle)
    }
}

extension Dictionary {
    
    func updated(with dictionary: Dictionary) -> Dictionary {
        var updatedDictionary = self
        
        for (key, value) in dictionary {
            updatedDictionary.updateValue(value, forKey: key)
        }
        
        return updatedDictionary
    }
}

