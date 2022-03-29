//
//  MultilineButton.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit

public class MultilineButton: UIButton {
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel?.preferredMaxLayoutWidth = titleLabel?.frame.width ?? 0
        layoutIfNeeded()
    }
    
    public override var intrinsicContentSize: CGSize {
        let idealLabelSize = titleLabel?.systemLayoutSizeFitting(frame.size) ?? self.frame.size
        let idealWidth = max(idealLabelSize.width, frame.size.width)
        let idealHeight = max(idealLabelSize.height, frame.size.height)
        
        return CGSize(width: ceil(idealWidth),
                      height: ceil(idealHeight))
    }
}
