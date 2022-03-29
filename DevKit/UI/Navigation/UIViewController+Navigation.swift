//
//  UIViewController+Navigation.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit

extension UIViewController {
    
    public func setNavigationBar(type: NavigationViewModel.TitleType, color: UIColor = Configuration.shared.navigation.titleColor) {
        switch type {
        case .text(let title):
            let font = Configuration.shared.navigation.titleFont
            let height = CGFloat(44.0)
            let width = title.widthWithConstrainedHeight(height, font: font)
            let titleLabel = UILabel(frame: CGRect(x: view.frame.size.width * 0.5 - (width * 0.5),
                                                   y:0,
                                                   width: width,
                                                   height: height))
            titleLabel.font = font
            titleLabel.numberOfLines = 0
            titleLabel.textAlignment = .center
            titleLabel.textColor = color
            titleLabel.text = title
            titleLabel.adjustsFontSizeToFitWidth = true
            self.navigationItem.titleView = titleLabel
        case .searchBar(let placeholderText, let delegate):
            if let searchBar = navigationItem.titleView as? UISearchBar {
                searchBar.placeholder = placeholderText
            } else {
                let searchBar = UISearchBar()
                searchBar.delegate = delegate
                searchBar.placeholder = placeholderText
                navigationItem.titleView = searchBar
            }
        }
        
    }
    
    public func setClearNavigationBar(withTintColor tintColor: UIColor? = nil) {
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = .clear
        
        if let color = tintColor {
            navigationController?.navigationBar.tintColor = color
        }
        
        hideNavigationBarSeparator()
    }
    
    @available(iOS, deprecated: 11.0, message: "see comment below")
    public func showNavigationBarSeparator() {
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }
    
    @available(iOS, deprecated: 11.0, message: "see comment below")
    public func hideNavigationBarSeparator() {
        // We use `setBackgroundImage(UIImage(), for: .default)` to
        // solve the navigation bar bottom border issue in iOS10
        // Please remove it once we drop iOS10.* support
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    public func showEmptybackBarButtonItemTitle() {
        let backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    public func hideBackButton() {
        navigationItem.hidesBackButton      = true
        navigationItem.leftBarButtonItem    = nil
    }
    
    public func showBackButton() {
        navigationItem.hidesBackButton      = false
    }
    
    public var rightButtonIsEnabled: Bool {
        get {
            let button = navButton(items: self.navigationItem.rightBarButtonItems)
            return button?.isEnabled ?? false
        }
        set {
            disableFirstInItem(isEnabled: newValue, items: self.navigationItem.rightBarButtonItems)
        }
    }
    
    public var leftButtonIsEnabled: Bool {
        get {
            let button = navButton(items: self.navigationItem.leftBarButtonItems)
            return button?.isEnabled ?? false
        }
        set {
            disableFirstInItem(isEnabled: newValue, items: self.navigationItem.leftBarButtonItems)
        }
    }
    
    func leftButton(isEnabled: Bool) {
        disableFirstInItem(isEnabled: isEnabled, items: self.navigationItem.leftBarButtonItems)
    }
    
    func disableFirstInItem(isEnabled: Bool, items: [UIBarButtonItem]?) {
        let button                          = navButton(items: items)
        button?.isEnabled                   = isEnabled
    }
    
    func navButton(items: [UIBarButtonItem]?) -> UIButton? {
        guard let sitems = items?.dropFirst(), let barItem = sitems.first else { return nil }
        guard let button = barItem.customView as? UIButton else { return nil }
        return button
    }
    
    public func rightButton(title: String, color: UIColor, target: Any, action: Selector) {
        let button                          = navbutton(title: title, color: color)
        button.addTarget(target, action: action, for: .touchUpInside)
        right(buttons: [button])
    }
    
    public func leftButton(attributedTitle: NSAttributedString, target: Any, action: Selector) {
        showBackButton()
        let button                          = navbutton(attributedTitle: attributedTitle)
        button.addTarget(target, action: action, for: .touchUpInside)
        left(buttons: [button])
    }
    
    public func rightButton(attributedTitle: NSAttributedString, target: Any, action: Selector) {
        let button                          = navbutton(attributedTitle: attributedTitle)
        button.addTarget(target, action: action, for: .touchUpInside)
        right(buttons: [button])
    }
    
    public func leftButton(title: String, color: UIColor, target: Any, action: Selector) {
        showBackButton()
        let button                          = navbutton(title: title, color: color)
        button.addTarget(target, action: action, for: .touchUpInside)
        left(buttons: [button])
    }
    
    public func backButton(imageName: String, target: Any, action: Selector, margin: CGFloat = 0.0) {
        showBackButton()
        
        if let button = makeButton(withImageName: imageName, target: target, action: action) {
            left(buttons: [button], margin: margin)
        }
        
        // brings back the swipe back message
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    public func backButtonSupport(target: Any, action: Selector, margin: CGFloat = 0.0) {
        backButton(imageName: Image.supportBubble.rawValue, target: target, action: action, margin: margin)
    }
    
    public func rightButton(imageName: String, selectedImageName: String? = nil, target: Any, action: Selector, margin: CGFloat = 0.0) {
        if let button = makeButton(withImageName: imageName, selectedImageName: selectedImageName, alignment: .right, target: target, action: action) {
            right(buttons: [button], margin: margin)
        }
    }
    
    public func leftButton(imageName: String, selectedImageName: String? = nil, target: Any, action: Selector, margin: CGFloat = 0.0) {
        if let button = makeButton(withImageName: imageName, selectedImageName: selectedImageName, alignment: .right, target: target, action: action) {
            left(buttons: [button], margin: margin)
        }
    }
    
    public func backButtonWhiteArrow(target: Any, action: Selector) {
        backButton(imageName: Image.backArrowWhite.rawValue, target: target, action: action)
    }
    
    public func navbutton(title: String, color: UIColor) -> UIButton {
        let button = UIButton(type: .custom)
        button.titleLabel?.font = Configuration.shared.navigation.buttonFont
        button.setTitle(title, for: .normal)
        button.setTitleColor(color, for: .normal)
        button.setTitleColor(color.highlighted, for: .highlighted)
        button.setTitleColor(color.selected, for: .selected)
        button.setTitleColor(color.disabled, for: .disabled)
        let buttonSize = CGFloat(40).deviceScaled
        let width = title.widthWithConstrainedHeight(buttonSize, font: Configuration.shared.navigation.buttonFont)
        button.frame = CGRect(x: 0, y: 0, width: Swift.max(width + CGFloat(16).deviceScaled, buttonSize), height: buttonSize)
        return button
    }
    
    public func navbutton(attributedTitle: NSAttributedString) -> UIButton {
        let button = UIButton(type: .custom)
        button.setAttributedTitle(attributedTitle, for: .normal)
        let buttonSize = CGFloat(40).deviceScaled
        let width = attributedTitle.widthWithConstrainedHeight(buttonSize)
        button.frame = CGRect(x: 0, y: 0, width: Swift.max(width + CGFloat(16).deviceScaled, buttonSize), height: buttonSize)
        return button
    }
    
    public func navButton(image: ImageInterface, title: String, color: UIColor, imageTextSpacing: CGFloat = 6.0) -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.setImage(image.image, for: .normal)
        button.titleLabel?.font = Configuration.shared.navigation.buttonFont
        button.titleLabel?.setContentCompressionResistancePriority(.required, for: .horizontal)
        button.titleLabel?.setContentCompressionResistancePriority(.required, for: .vertical)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: imageTextSpacing)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: imageTextSpacing, bottom: 0, right: 0)
        
        if let titleSize = button.titleLabel?.intrinsicContentSize,
            let imageSize = button.image(for: .normal)?.size {
            button.frame = CGRect(origin: .zero, size: CGSize(
                width: titleSize.width + imageTextSpacing + imageSize.width,
                height: Swift.max(titleSize.height, imageSize.height)
            ))
        }
        
        return button
    }
    
    public func left(buttons: [UIButton], margin: CGFloat = -4) {
        self.navigationItem.leftBarButtonItems = prep(buttons: buttons, margin: margin)
    }
    
    public func right(buttons: [UIButton], margin: CGFloat = -4) {
        self.navigationItem.rightBarButtonItems = prep(buttons: buttons, margin: margin)
    }
    
    func prep(buttons: [UIButton], margin: CGFloat) -> [UIBarButtonItem] {
        let marginItem                      = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        marginItem.width                    = margin
        let items = buttons.reduce([marginItem]) { its, nextButton in
            let bbi                         = UIBarButtonItem(customView: nextButton)
            return its + [bbi]
        }
        return items
    }
    
    public func rightBarButtonItem(withImageName imageName: String, selectedImageName: String? = nil, target: Any, action: Selector) -> UIBarButtonItem? {
        if let button = makeButton(withImageName: imageName, selectedImageName: selectedImageName, alignment: .right, target: target, action: action) {
            return UIBarButtonItem(customView: button)
        }
        
        return nil
    }
    
    private func makeButton(withImageName imageName: String, selectedImageName: String? = nil, alignment: UIControl.ContentHorizontalAlignment = .left, target: Any, action: Selector) -> UIButton? {
        guard let image = Image(rawValue: imageName)?.image else {
            return nil
        }
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: Swift.max(40, image.size.width), height: Swift.max(40, image.size.height))
        button.setImage(image, for: .normal)
        if let selectedImageName = selectedImageName, let selectedImage = Image(rawValue: selectedImageName)?.image {
            button.setImage(selectedImage, for: .selected)
        }
        button.contentHorizontalAlignment = alignment
        button.addTarget(target, action: action, for: .touchUpInside)
        
        return button
    }
}

extension UINavigationController {
    
    @discardableResult
    public func withLegacyAppearance() -> Self {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.titleTextAttributes = Attributes().withFont(Configuration.shared.navigation.titleFont).withForegroundColor(.white).attributes
        navigationBar.tintColor = .white
        return self
    }
    
    
    public func clear() {
        navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        navigationBar.shadowImage           = UIImage()
        navigationBar.barTintColor          = .clear
        navigationBar.isTranslucent         = true
    }
    
    public func set(color: UIColor) {
        navigationBar.setBackgroundImage(nil, for: .any, barMetrics: .default)
        navigationBar.shadowImage           = nil
        navigationBar.barTintColor          = color
        navigationBar.isTranslucent         = false
    }
    
    public func setWhite() {
        set(color: .white)
    }
    
    public func pushViewController(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        pushViewController(viewController, animated: animated)
        
        if animated, let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion?()
            }
        } else {
            completion?()
        }
    }
    
    public func popViewController(animated: Bool, completion: (() -> Void)? = nil) {
        popViewController(animated: animated)
        
        if animated, let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion?()
            }
        } else {
            completion?()
        }
    }
    
    public func popToRootViewController(animated: Bool, completion: (() -> Void)? = nil) {
        popToRootViewController(animated: animated)
        
        if animated, let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion?()
            }
        } else {
            completion?()
        }
    }
    
    public func setViewControllers(viewControllers: [UIViewController], animated: Bool, completion: (() -> Void)? = nil) {
        setViewControllers(viewControllers, animated: animated)
        
        if animated, let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion?()
            }
        } else {
            completion?()
        }
    }
}

private extension UIViewController {
    
    private func setNavigationBar(color: UIColor) {
        navigationController?.navigationBar.barTintColor = color
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.tintColor = .white
        
        hideNavigationBarSeparator()
    }
}

