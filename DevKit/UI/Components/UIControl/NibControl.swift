//
//  NibControl.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/17/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit

/// A base class that provides loading logic for a control built in a .xib.
///
/// How to:
/// - Create a .xib with your layout
/// - Create a subclass of NibControl with the same name as the .xib
/// - Don't specify the class name in the .xib
/// - Specify the File Owner, and then set up the outlets

open class NibControl: UIControl, NibLoadable {
    
    public override var didTap: UIControlTapClosure? {
        get {
            return (subviews.first as? UIControl)?.didTap
        }
        
        set {
            (subviews.first as? UIControl)?.didTap = newValue
        }
    }
    
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
