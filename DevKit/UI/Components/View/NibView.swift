//
//  NibView.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit

/// A base class that provides loading logic for a view built in a .xib.
///
/// How to:
/// - Create a .xib with your layout
/// - Create a subclass of NibView with the same name as the .xib
/// - Don't specify the class name in the .xib
/// - Specify the File Owner, and then set up the outlets

open class NibView: UIView, NibLoadable {
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        loadNibContent()
    }
}
