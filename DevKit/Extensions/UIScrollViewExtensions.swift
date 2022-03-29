//
//  UIScrollViewExtensions.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    public var minContentOffset: CGPoint {
        return CGPoint(x: -contentInset.left,
                       y: -contentInset.top)
    }
    
    public var maxContentOffset: CGPoint {
        return CGPoint(x: contentSize.width - bounds.width + contentInset.right,
                       y: contentSize.height - bounds.height + contentInset.bottom)
    }
    
    public func scrollToTop(animated: Bool) {
        setContentOffset(minContentOffset, animated: animated)
    }
    
    public func scrollToBottom(animated: Bool) {
        setContentOffset(maxContentOffset, animated: animated)
    }
    
}
