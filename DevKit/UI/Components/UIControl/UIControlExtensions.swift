//
//  UIControlExtensions.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit

private var key = "DevKit.UIControl.didTap"

public typealias UIControlTapClosure = (() -> Void)

extension UIControl {
    
    @objc public var didTap: UIControlTapClosure? {
        get {
            return objc_getAssociatedObject(self, &key) as? UIControlTapClosure
        }
        
        set {
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            removeTarget(nil, action: nil, for: .touchUpInside)
            addTarget(self, action: #selector(didTapControl(_:)), for: .touchUpInside)
        }
    }
}

private extension UIControl {
    
    @objc func didTapControl(_ control: UIControl) {
        didTap?()
    }
}
