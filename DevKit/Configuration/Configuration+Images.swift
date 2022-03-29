//
//  Configuration+Images.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/9/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import Foundation

public extension Configuration {
    
    struct Images {
        let backArrowWhite: UIImage?
        let dismissButtonWhite: UIImage?
        let supportBubble: UIImage?
        let glossary: UIImage?
        let aboutIconLarge: UIImage?
        let moreMenuVertical: UIImage?
        let settings: UIImage?
        
        public init(backArrowWhite: UIImage? = Image.backArrowWhite.image, dismissButtonWhite: UIImage? = Image.dismissButtonWhite.image, supportBubble: UIImage? = Image.supportBubble.image, glossary: UIImage? = Image.glossary.image, aboutIconLarge: UIImage? = Image.aboutIcon.image, moreMenuVertical: UIImage? = Image.moreMenuVertical.image, settings: UIImage? = Image.settings.image) {
            self.backArrowWhite = backArrowWhite
            self.dismissButtonWhite = dismissButtonWhite
            self.supportBubble = supportBubble
            self.glossary = glossary
            self.aboutIconLarge = aboutIconLarge
            self.moreMenuVertical = moreMenuVertical
            self.settings = settings
        }
    }
}
