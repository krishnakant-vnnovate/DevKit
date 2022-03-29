//
//  UIButtonExtensions.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit

extension UIButton {
    
    public func setBackgroundColor(_ color: UIColor, forState: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()?.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(colorImage, for: forState)
    }
    
    public func setSpacing(_ spacing: CGFloat) {
        let spacingSign: CGFloat = semanticContentAttribute == .forceRightToLeft ? -1 : 1
        let halfSpacing = spacing/2
        
        contentEdgeInsets = UIEdgeInsets(
            top: 0,
            left: halfSpacing,
            bottom: 0,
            right: halfSpacing
        )
        
        titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: spacingSign * halfSpacing,
            bottom: 0,
            right: spacingSign * -halfSpacing
        )
        
        imageEdgeInsets = UIEdgeInsets(
            top: 0,
            left: spacingSign * -halfSpacing,
            bottom: 0,
            right: spacingSign * halfSpacing
        )
        
    }
    
    public func alignImageAndTitleVertically(padding: CGFloat = 4) {
        guard let imageViewSize = self.imageView?.frame.size,
            let titleLabelSize = self.titleLabel?.frame.size else {
                return
        }
        
        let totalHeight = imageViewSize.height + titleLabelSize.height + padding
        
        imageEdgeInsets = UIEdgeInsets(
            top: -(totalHeight - imageViewSize.height),
            left: 0,
            bottom: 0,
            right: -titleLabelSize.width
        )
        
        titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: -imageViewSize.width,
            bottom: -(totalHeight - titleLabelSize.height),
            right: 0
        )
        
        contentEdgeInsets = UIEdgeInsets(
            top: min(titleLabelSize.height, imageViewSize.height),
            left: 0,
            bottom: min(titleLabelSize.height, imageViewSize.height),
            right: 0
        )
    }
    
    public func setTitle(_ title: @autoclosure () -> String?, for state: UIControl.State, animated: Bool) {
        if animated {
            return setTitle(title(), for: state)
        }
        
        UIView.performWithoutAnimation {
            setTitle(title(), for: state)
            layoutIfNeeded()
        }
    }
    
    public func setAttributedTitle(_ title: @autoclosure () -> NSAttributedString?, for state: UIControl.State, animated: Bool) {
        if animated {
            return setAttributedTitle(title(), for: state)
        }
        
        UIView.performWithoutAnimation {
            setAttributedTitle(title(), for: state)
            layoutIfNeeded()
        }
    }
}
