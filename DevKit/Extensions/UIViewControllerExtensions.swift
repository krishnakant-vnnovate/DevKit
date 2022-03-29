//
//  UIViewControllerExtensions.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/15/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit

extension UIViewController {
    
    public func addChildViewController(_ viewConroller: UIViewController, to containerView: UIView) {
        containerView.addSubview(viewConroller.view)
        addChild(viewConroller)
        viewConroller.view.snp.makeConstraints { make in
            make.edges.equalTo(containerView)
        }
        viewConroller.didMove(toParent: self)
    }
    
    public func removeFromSuperview() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    public var safeAreaInsets: UIEdgeInsets {
        let bottomInset: CGFloat
        let leftInset: CGFloat
        let rightInset: CGFloat
        let topInset: CGFloat
        
        if #available(iOS 11.0, *) {
            bottomInset = view.safeAreaInsets.bottom
            leftInset = view.safeAreaInsets.left
            rightInset = view.safeAreaInsets.right
            topInset = view.safeAreaInsets.top
        } else {
            bottomInset = bottomLayoutGuide.length
            topInset = topLayoutGuide.length
            leftInset = 0
            rightInset = 0
        }
        
        return .init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
    }
    
}

extension UINavigationController {
    
    public var canPop: Bool {
        return viewControllers.count > 1
    }
    
    public func popOrDismissIfRoot() {
        if canPop {
            popViewController(animated: true)
        } else {
            dismiss(animated: true)
        }
    }
}
