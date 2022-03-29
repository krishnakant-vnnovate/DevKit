//
//  NSAttributedStringExtensions.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit

public extension NSAttributedString {
    
    convenience init(format: String, attributes: [NSAttributedString.Key: Any]? = nil, _ args: NSAttributedString...) {
        let argsComponents: [NSAttributedString] = args.map { $0 }
        
        self.init(format: format, attributes: attributes, argsComponents)
    }
    
    convenience init(format: String, attributes: [NSAttributedString.Key: Any]? = nil, _ args: [NSAttributedString]) {
        let attrib = NSMutableAttributedString()
        let components = format.components(separatedBy: "%@")
        
        components.enumerated().forEach {
            attrib.append(NSAttributedString(string: $1, attributes: attributes ?? [:]))
            if $0 < args.count {
                attrib.append(args[$0])
            }
        }
        
        self.init(attributedString: attrib)
    }
    
    convenience init(
        attachmentImage image: UIImage,
        size: CGSize,
        originOffset: CGPoint,
        text: String,
        attributes: [NSAttributedString.Key: Any]?) {
        
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = CGRect(origin: originOffset, size: size)
        
        let content = NSMutableAttributedString()
        content.append(NSAttributedString(attachment: attachment))
        content.append(NSAttributedString(string: " "))
        content.append(NSAttributedString(string: text, attributes: attributes))
        self.init(attributedString: content)
    }
    
    convenience init(string: String, attributes: NSAttributes, hyperlinks: [String: URL?], hyperlinkAttributes: NSAttributes) {
        let attributedText = NSMutableAttributedString(string: string, attributes: attributes)
        hyperlinks.forEach { hyperlink, url in
            guard let url = url else { return }
            let linkRange = attributedText.mutableString.range(of: hyperlink)
            attributedText.addAttribute(.link, value: url, range: linkRange)
            attributedText.addAttributes(hyperlinkAttributes, range: linkRange)
        }
        self.init(attributedString: attributedText)
    }
    
    convenience init(string: String, stashAttributes: Attributes, hyperlinks: [String: URL?], hyperlinkAttributes: Attributes) {
        self.init(string: string, attributes: stashAttributes.attributes, hyperlinks: hyperlinks, hyperlinkAttributes: hyperlinkAttributes.attributes)
    }
    
    convenience init(string: String, attributes: NSAttributes, attributedSubstrings: [String: NSAttributes]) {
        let attributedText = NSMutableAttributedString(string: string, attributes: attributes)
        attributedSubstrings.forEach { string, attributes in
            let linkRange = attributedText.mutableString.range(of: string)
            attributedText.addAttributes(attributes, range: linkRange)
        }
        self.init(attributedString: attributedText)
    }
    
    convenience init(string: String, stashAttributes: Attributes, attributedSubstrings: [String: Attributes]) {
        let attributedSubstrings = attributedSubstrings.mapValues { $0.attributes }
        self.init(string: string, attributes: stashAttributes.attributes, attributedSubstrings: attributedSubstrings)
    }
    
    convenience init(string: String, stashAttributes: Attributes) {
        self.init(string: string, attributes: stashAttributes.attributes)
    }
}

public typealias NSAttributes = [NSAttributedString.Key: Any]
