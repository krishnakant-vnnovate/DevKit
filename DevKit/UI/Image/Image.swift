//
//  Image.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import Foundation

public enum Image: String {
    case backArrowWhite
    case dismissButtonWhite
    case supportBubble
    case glossary
    case aboutIcon
    case moreMenuVertical
    case settings
}

public protocol ImageInterface {
    var image: UIImage? { get }
    var templateImage: UIImage? { get }
}

public extension ImageInterface {
    
    var templateImage: UIImage? {
        return image?.withRenderingMode(.alwaysTemplate)
    }
}

extension Image: ImageInterface {
    
    public var image: UIImage? {
//        if let imageFromConfiguration = imageFromConfiguration {
//            return imageFromConfiguration
//        }
        return UIImage(named: rawValue, in: Bundle(for: BundleFinder.self), compatibleWith: nil)
    }
    
}

private class BundleFinder {}

extension String: ImageInterface {
    
    public var image: UIImage? {
        guard let dataDecoded = Data(base64Encoded: self, options: .ignoreUnknownCharacters) else {
            return nil
        }
        
        return UIImage(data: dataDecoded)
    }
}

extension UIImage {
    
    public var asAttributedString: NSAttributedString {
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = self
        return NSAttributedString(attachment: imageAttachment)
    }
    
}

public func ==(lhs: ImageInterface, rhs: ImageInterface) -> Bool {
    return lhs.image == rhs.image && lhs.templateImage == rhs.templateImage
}

extension Image {
    
    var imageFromConfiguration: UIImage? {
        let configuration = Configuration.shared.images
        switch self {
        case .backArrowWhite:
            return configuration.backArrowWhite
        case .dismissButtonWhite:
            return configuration.dismissButtonWhite
        case .supportBubble:
            return configuration.supportBubble
        case .glossary:
            return configuration.glossary
        case .aboutIcon:
            return configuration.aboutIconLarge
        case .moreMenuVertical:
            return configuration.moreMenuVertical
        case .settings:
            return configuration.settings
        }
    }
}
