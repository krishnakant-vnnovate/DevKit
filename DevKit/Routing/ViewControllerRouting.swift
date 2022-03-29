//
//  ViewControllerRouting.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/15/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit

public enum PresentationStyle {
    case push
    case present
}

public protocol ViewControllerContaining: class {
    var viewController: UIViewController? { get set }
}

public protocol ViewControllerCreating: class {
    func createViewController() -> UIViewController
}

public protocol Dismissable: class {
    func dismiss()
}

public extension Dismissable where Self: ViewControllerRouting {

    func dismiss() {
        dismissBlock?()
    }
}

public protocol ViewControllerPushing {
    func push(on navigationController: UINavigationController)
    func push(on navigationController: UINavigationController, animated: Bool)
    func pushAndReplaceStack(on navigationController: UINavigationController, animated: Bool)
    func pushAndReplaceLast(on navigationController: UINavigationController, animated: Bool)
}

public protocol ViewControllerRouting: ViewControllerContaining & ViewControllerCreating & ViewControllerPushing {
    var presentationStyle: PresentationStyle? { get set }

    @discardableResult
    func present(on viewController: UIViewController) -> UINavigationController
    @discardableResult
    func present(on viewController: UIViewController, animated: Bool, transitionStyle: UIModalTransitionStyle, presentationStyle: UIModalPresentationStyle) -> UINavigationController
}

private var keyDismissBlock = "com.vgusakov.devkit.viewControllerRouting.dismissBlock"
private var keyPresentationStyle = "com.vgusakov.devkit.viewControllerRouting.presentationStyle"

extension ViewControllerRouting {

    public var presentationStyle: PresentationStyle? {
        get {
            return objc_getAssociatedObject(self, &keyPresentationStyle) as? PresentationStyle
        }
        set {
            objc_setAssociatedObject(self, &keyPresentationStyle, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }

    fileprivate var dismissBlock: (() -> Void)? {
        get {
            return objc_getAssociatedObject(self, &keyDismissBlock) as? (() -> Void)
        }
        set {
            objc_setAssociatedObject(self, &keyDismissBlock, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }

    public func push(on navigationController: UINavigationController, animated: Bool = true) {
        let vc = createViewController()
        self.viewController = vc
        self.presentationStyle = .push
        navigationController.pushViewController(vc, animated: animated)
        dismissBlock = { [weak navigationController] in
            navigationController?.popOrDismissIfRoot()
        }
    }

    public func push(on navigationController: UINavigationController) {
        push(on: navigationController, animated: true)
    }

    public func routeToBookMark(on navigationController: UINavigationController, animated: Bool) {
        let newStack: [UIViewController] = {
            guard let lastBookmarkIndex = navigationController.viewControllers.lastIndex(where: { $0.isBookmarked }) else {
                return []
            }

            let stackWithBookmark = navigationController.viewControllers[0...lastBookmarkIndex]
            return Array(stackWithBookmark)
        }()
        viewController?.unbookmark()
        navigationController.setViewControllers(newStack, animated: animated)
    }

    public func pushAndReplaceStack(on navigationController: UINavigationController, animated: Bool) {
        let vc = createViewController()
        self.viewController = vc
        self.presentationStyle = .push

        let newStack: [UIViewController] = {
            guard let lastBookmarkIndex = navigationController.viewControllers.lastIndex(where: { $0.isBookmarked }) else {
                return [vc]
            }

            let stackWithBookmark = navigationController.viewControllers[0...lastBookmarkIndex]
            return Array(stackWithBookmark) + vc
        }()

        navigationController.setViewControllers(newStack, animated: animated)
        dismissBlock = { [weak navigationController] in
            navigationController?.popOrDismissIfRoot()
        }
    }

    public func pushAndReplaceLast(on navigationController: UINavigationController, animated: Bool) {
        let vc = createViewController()
        self.viewController = vc
        self.presentationStyle = .push

        let newStack = navigationController.viewControllers[0..<max(0, navigationController.viewControllers.count - 1)] + [vc]
        navigationController.setViewControllers(Array(newStack), animated: animated)
        dismissBlock = { [weak navigationController] in
            navigationController?.popOrDismissIfRoot()
        }
    }

    @discardableResult
    public func present<T: UINavigationController>(on viewController: UIViewController) -> T {
        return present(on: viewController, animated: true)
    }

    @discardableResult
    public func present<T: UINavigationController>(on viewController: UIViewController, animated: Bool, transitionStyle: UIModalTransitionStyle = .coverVertical, presentationStyle: UIModalPresentationStyle = .fullScreen) -> T {
        let vc = createViewController()
        self.viewController = vc
        self.presentationStyle = .present
        let navController = T(rootViewController: vc)
        navController.modalPresentationStyle = presentationStyle
        navController.modalTransitionStyle = transitionStyle
        viewController.present(navController, animated: animated)
        dismissBlock = { [weak viewController] in
            viewController?.dismiss(animated: true)
        }
        return navController
    }
}

private var viewControllerBookmarked = "com.vgusakov.devkit.viewControllerBookmarked"

extension UIViewController {

    var isBookmarked: Bool {
        return objc_getAssociatedObject(self, &viewControllerBookmarked) as? Bool ?? false
    }

    public func bookmark() {
        objc_setAssociatedObject(self, &viewControllerBookmarked, true, .OBJC_ASSOCIATION_COPY)
    }

    public func unbookmark() {
        objc_setAssociatedObject(self, &viewControllerBookmarked, false, .OBJC_ASSOCIATION_COPY)
    }

}

extension UINavigationController {

    public static func withWireframe(_ wireframe: ViewControllerPushing) -> UINavigationController {
        let navigationController = UINavigationController()
        wireframe.pushAndReplaceStack(on: navigationController, animated: false)

        return navigationController
    }
}
