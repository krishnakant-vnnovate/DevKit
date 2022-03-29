//
//  ScrollView.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit
import SnapKit

open class ScrollView: UIScrollView {
    
    open private(set) var contentView: UIView = PassThroughView()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        alwaysBounceVertical = false
        alwaysBounceHorizontal = false
        addSubview(contentView)
    }
    
    open override func updateConstraints() {
        super.updateConstraints()
        
        contentView.snp.remakeConstraints { make in
            make.edges.equalTo(self)
            var insets: UIEdgeInsets = .zero
            if #available(iOS 11.0, *) {
                insets = safeAreaInsets
            }
            make.height.equalTo(self).inset(insets).priority(.low)
            make.width.equalTo(self)
        }
        contentView.backgroundColor = .clear
    }
    
    open func setContentView(with view: UIView) {
        contentView.removeFromSuperview()
        contentView = view
        addSubview(contentView)
        setNeedsUpdateConstraints()
    }
}

private class PassThroughView: UIView {
    
    override public func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for subview in subviews {
            if !subview.isHidden && subview.isUserInteractionEnabled && subview.point(inside: convert(point, to: subview), with: event) {
                return true
            }
        }
        return false
    }
}
