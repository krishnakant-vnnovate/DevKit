//
//  UIRefreshControlExtensions.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit

private var key = "DevKit.UIRefreshControl.didDrag"

public typealias RefreshControlDragClosure = ((UIRefreshControl) -> Void)

extension UIRefreshControl {
    
    public var didDrag: RefreshControlDragClosure? {
        get {
            return objc_getAssociatedObject(self, &key) as? RefreshControlDragClosure
        }
        
        set {
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            removeTarget(nil, action: nil, for: .valueChanged)
            addTarget(self, action: #selector(didDragControl(_:)), for: .valueChanged)
        }
    }
}

private extension UIRefreshControl {
    @objc func didDragControl(_ control: UIRefreshControl) {
        didDrag?(control)
    }
}
