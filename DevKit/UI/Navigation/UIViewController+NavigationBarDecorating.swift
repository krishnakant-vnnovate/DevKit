//
//  UIViewController+NavigationBarDecorating.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit

public typealias BarButtonItemHandler = () -> Void

public extension NavigationBarDecorating where Self: UIViewController {
    
    func configureNavigation(with viewModel: NavigationViewModel) {
        setNavigationBar(type: viewModel.type)
        setupBackButton(viewModel.leftButton)
        setupRightButtons(viewModel.rightButtons)
    }
    
    func setupBackButton(_ button: NavigationButton?) {
        guard let button = button else {
            left(buttons: [])
            navigationController?.interactivePopGestureRecognizer?.isEnabled = false
            return
        }
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = navigationController?.viewControllers.count != 1
        
        switch button.buttonType {
        case .text(let title, let textColor):
            leftButton(title: title, color: textColor) { button.closure() }
        case .attributedText(let attributedTitle):
            leftButton(attributedTitle: attributedTitle) { button.closure() }
        case .image(let image):
            backButton(image: image.image, closure: { button.closure() })
        case .circular(let image):
            leftCircularButton(image: image.image)
        }
    }
    
    func setupRightButtons(_ buttons: [NavigationButton]) {
        let navigationButtons = buttons.compactMap(rightButton)
        right(buttons: navigationButtons)
    }
}

private extension NavigationBarDecorating where Self: UIViewController {
    
    func backButton(image: UIImage?, closure: BarButtonItemHandler? = nil) {
        showBackButton()
        
        if let button = makeButton(withImage: image, closure: closure) {
            left(buttons: [button], margin: 0.0)
        }
        
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    func leftButton(title: String, color: UIColor, closure: BarButtonItemHandler? = nil) {
        showBackButton()
        let button = navbutton(title: title, color: color)
        button.didTap = closure
        left(buttons: [button])
    }
    
    func leftButton(attributedTitle: NSAttributedString, closure: BarButtonItemHandler? = nil) {
        showBackButton()
        let button = navbutton(attributedTitle: attributedTitle)
        button.didTap = closure
        left(buttons: [button])
    }
    
    func leftCircularButton(image: UIImage?, closure: BarButtonItemHandler? = nil) {
        showBackButton()
        let button = makeCircularButton(withImage: image, closure: closure)
        left(buttons: [button].compactMap { $0 })
    }
}

private extension NavigationBarDecorating where Self: UIViewController {
    
    func rightButton(_ navigationButton: NavigationButton?) -> UIButton? {
        guard let navigationButton = navigationButton else { return nil }
        
        switch navigationButton.buttonType {
        case .text(let title, let textColor):
            return rightButton(title: title, color: textColor) { navigationButton.closure() }
        case .attributedText(let attributedTitle):
            return rightButton(attributedTitle: attributedTitle) { navigationButton.closure() }
        case .image(let image):
            return rightButton(image: image.image, closure: { navigationButton.closure() })
        case .circular(let image):
            return makeCircularButton(withImage: image.image) { navigationButton.closure() }
        }
    }
    
    func rightButton(title: String, color: UIColor, closure: BarButtonItemHandler? = nil) -> UIButton {
        let button = navbutton(title: title, color: color)
        button.didTap = closure
        return button
    }
    
    func rightButton(attributedTitle: NSAttributedString, closure: BarButtonItemHandler? = nil) -> UIButton {
        showBackButton()
        let button = navbutton(attributedTitle: attributedTitle)
        button.didTap = closure
        return button
    }
    
    func rightButton(image: UIImage?, selectedImage: Image? = nil, closure: BarButtonItemHandler? = nil) -> UIButton? {
        return makeButton(withImage: image, selectedImage: selectedImage?.image, alignment: .right, closure: closure)
    }
}

private extension NavigationBarDecorating where Self: UIViewController {
    
    func makeButton(
        withImage image: UIImage?,
        selectedImage: UIImage? = nil,
        alignment: UIControl.ContentHorizontalAlignment = .left,
        closure: BarButtonItemHandler? = nil) -> UIButton? {
        guard let image = image else { return nil }
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: Swift.max(40, image.size.width), height: Swift.max(40, image.size.height))
        button.setImage(image, for: .normal)
        if let selectedImage = selectedImage {
            button.setImage(selectedImage, for: .selected)
        }
        button.contentHorizontalAlignment = alignment
        button.didTap = closure
        
        return button
    }
    
    func makeCircularButton(withImage image: UIImage?, closure: BarButtonItemHandler?) -> UIButton? {
        guard let image = image else { return nil }
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0,
                              y: 0,
                              width: 35,
                              height: 35)
        button.backgroundColor = .clear
        button.layer.cornerRadius = button.frame.height * 0.5
        button.setImage(image, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        button.imageView?.contentMode = .scaleAspectFit
        button.didTap = closure
        
        return button
    }
}
