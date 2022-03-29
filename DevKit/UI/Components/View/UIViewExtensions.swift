//
//  UIViewExtensions.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit

extension UIView {
    
    public func animateConstraintChanges(withDuration duration: TimeInterval, animations: () -> Void) {
        animations()
        
        UIView.animate(withDuration: duration, animations: {
            self.layoutIfNeeded()
        })
    }
    
    public func setHiddenAnimated(_ isHidden: Bool, duration: TimeInterval = 0.2) {
        guard self.isHidden != isHidden else { return }
        self.isHidden = false
        self.alpha = isHidden ? 1 : 0
        
        UIView.animate(withDuration: duration, animations: {
            self.alpha = isHidden ? 0 : 1
        }) { _ in
            self.isHidden = isHidden
        }
    }
    
    public func blink() {
        self.alpha = 0.2
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [.curveLinear], animations: {self.alpha = 1.0}, completion: nil)
    }
    
    public var allSubviews: [UIView] {
        return subviews + subviews.flatMap({ $0.allSubviews })
    }
}

extension UIView {
    public typealias DropShadowControls = (hide: () -> Void, show: () -> Void)
    
    @discardableResult
    /**
     If the shadow doesn't draw correctly, try to call targetView.layoutIfNeeded() first
     */
    public func addDropShadow(withRoundedCorners roundCorners: Bool = true) -> DropShadowControls {
        let shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: bounds.size.width + 3, height: bounds.size.height + 3))
        layer.cornerRadius = roundCorners ? 8 : 0
        layer.shadowColor = UIColor(red: 26/255, green: 35/255, blue: 126/255, alpha: 1).cgColor
        layer.shadowOffset = CGSize(width: 0.5, height: 0.4)
        layer.shadowOpacity = 0.27
        
        layer.shadowRadius = 8
        layer.shadowPath = shadowPath.cgPath
        layer.masksToBounds = false
        
        return (hide: { [weak layer] in layer?.shadowOpacity = 0 },
                show: { [weak layer] in layer?.shadowOpacity = 0.27 })
    }
}
